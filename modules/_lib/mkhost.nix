{ config, inputs }:
let
  inherit (inputs)
    nixpkgs
    home-manager
    determinate
    nur
    rust-overlay
    agenix
    ;

  # All modules for NixOS (auto-imported via import-tree)
  nixosModules = builtins.attrValues config.flake.modules.nixos;

  # All modules for Home Manager (auto-imported via import-tree)
  homeManagerModules = builtins.attrValues config.flake.modules.homeManager;

  # NixOS module that defines dendrix options for host-specific configuration
  dendrixOptionsModule = import ./dendrix-options.nix;

  # Common NixOS modules included in every host
  commonNixosModules = [
    dendrixOptionsModule
    determinate.nixosModules.default
    nixpkgs.nixosModules.notDetected
    home-manager.nixosModules.home-manager
    nur.modules.nixos.default
    agenix.nixosModules.default
  ];

  # Common Home Manager settings
  commonHomeManagerSettings = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    sharedModules = homeManagerModules;
  };
in
# Host generator function
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
}
