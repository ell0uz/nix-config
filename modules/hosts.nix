{config, lib, inputs}: let
  inherit (inputs) nixpkgs home-manager;

  # All aspects for NixOS
  nixosMods = builtins.attrValues config.flake.modules.nixos;

  # All aspects for Home-Manager
  homeManagerMods = builtins.attrValues config.flake.modules.homeManager;

  # NixOS module that defines dendrix options for host-specific configuration
  drixOptionsMod = {lib,...}: {
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

  commonNixosModules = [
    drixOptionsMod
    determinate.nixosModules.default
    nixpkgs.nixosModules.notDetected
    nur.modules.nixos.default
    home-manager.nixosModules.home-manager
  ];

  commonHomeManagerSettings = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    sharedModules =
      homeManagerMods
  };

  mkHost = {hostname, hostModule, drixConfig, extraModules ? []}: {
    nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = commonNixosModules ++ nixosMods ++ [hostModule {dendrix = drixConfig;}  {
            home-manager =
              commonHomeManagerSettings
              // {
                users.farlion = {pkgs, ...}: {
                  home.stateVersion = dendrixConfig.homeStateVersion;
                };
              };}] ++ extraModules;
    };
  };
in
{
  # empty!
}
