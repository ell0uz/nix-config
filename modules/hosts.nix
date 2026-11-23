{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (inputs) nixpkgs home-manager determinate;

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
  ];

  # Common Home Manager settings
  commonHomeManagerSettings = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager-backup";
    sharedModules = homeManagerModules;
  };

  # Host generator function
  mkHost =
    {
      hostname,
      hostModule,
      dendrixConfig,
      extraModules ? [ ],
    }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs dendrixConfig;
        dendrix = dendrixConfig;
      };
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

          # Home-manager configuration
          {
            home-manager = commonHomeManagerSettings // {
              users.farlion = { pkgs, ... }: {
                home.stateVersion = dendrixConfig.homeStateVersion;
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
    flexbox = mkHost {
      hostname = "flexbox";
      hostModule = ./_hosts/flexbox;
      dendrixConfig = {
        hostname = "flexbox";
        stateVersion = "24.11";
        homeStateVersion = "24.11";
      };
    };
  };
}
