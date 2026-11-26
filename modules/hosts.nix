{ config, inputs, ... }:
let
  inherit (inputs) nixpkgs home-manager determinate nur rust-overlay;

  # All modules for NixOS (auto-imported via import-tree)
  nixosModules = builtins.attrValues (config.flake.modules.nixos or { });

  # All modules for Home Manager (auto-imported via import-tree)
  homeManagerModules = builtins.attrValues (config.flake.modules.homeManager or { });

  # NixOS module that defines dendrix options for host-specific configuration
  dendrixOptionsModule = { lib, ... }: {
    options.dendrix = {
      hostname = lib.mkOption {
        type = lib.types.str;
        description = "Hostname of this machine";
      };
      userName = lib.mkOption {
        type = lib.types.str;
        description = "User name for the primary user";
        default = "nixos";
      };
      stateVersion = lib.mkOption {
        type = lib.types.str;
        description = "NixOS state version for this host";
      };
      homeStateVersion = lib.mkOption {
        type = lib.types.str;
        description = "Home Manager state version for this host";
      };
    };
  };

  # Common NixOS modules included in every host
  commonNixosModules = [
    dendrixOptionsModule
    determinate.nixosModules.default
    nixpkgs.nixosModules.notDetected
    home-manager.nixosModules.home-manager
    nur.modules.nixos.default
  ];

  # Common Home Manager settings
  commonHomeManagerSettings = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    sharedModules = homeManagerModules;
  };

  # Host generator function
  mkHost =
    {
      hostModule,
      dendrixConfig,
      extraModules ? [ ],
    }:
    nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules =
        commonNixosModules
        ++ nixosModules
        ++ [
          # Host-specific hardware and settings
          hostModule

          # Set dendrix options
          {
            dendrix = dendrixConfig;
          }

          # Overlays
          {
            nixpkgs.overlays = [
              rust-overlay.overlays.default
            ];
          }

          # Home-manager configuration with dynamic username
          {
            home-manager = commonHomeManagerSettings // {
              users.${dendrixConfig.userName} = {
                home.stateVersion = dendrixConfig.homeStateVersion;
                home.username = dendrixConfig.userName;
              };
            };
          }
        ]
        ++ extraModules;
    };
in
{
  # Host configurations - explicitly defined using mkHost
  flake.nixosConfigurations = {
    winpooter = mkHost {
      hostModule = ./_hosts/winpooter;
      dendrixConfig = {
        hostname = "winpooter";
        userName = "ell";
        stateVersion = "26.05";
        homeStateVersion = "26.05";
      };
    };
    # qwq = mkHost {
    #   hostModule = ./_hosts/qwq;
    #   dendrixConfig = {
    #     hostname = "qwq";
    #     userName = "qwq";
    #     stateVersion = "26.11";
    #     homeStateVersion = "26.11";
    #   };
    # };
  };
}
