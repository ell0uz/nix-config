{ inputs, ... }: {
  # NOTE: Removed config from lambda pattern to remove dead code
  # Example host configuration
  # This file is in _hosts/example/ so it's skipped by import-tree (due to _ prefix)

  # Import features (modules/aspects) by name from inputs.self.modules.<class>
  imports = [
    # NixOS modules
    inputs.self.modules.nixos.some-feature
    inputs.self.modules.nixos.another-feature

    # Home Manager modules (wired automatically via home-manager.sharedModules in hosts.nix)
    # inputs.self.modules.homeManager.some-feature
    # inputs.self.modules.homeManager.another-feature
  ];

  # Host-specific configuration using dendrix options
  # These are typed options defined in hosts.nix -> dendrixOptionsModule

  # Example: Set hostname in networking (though dendrix.hostname is available for reference)
  # networking.hostName = config.dendrix.hostname;

  # Example: Conditional configuration based on state version
  # { config, lib, ... }: let
  #   cfg = config.dendrix;
  # in {
  #   # Use cfg.stateVersion or cfg.homeStateVersion for version-specific logic
  # };

  # Example: Hardware configuration (extend dendrix options in hosts.nix if needed)
  # hardware.nvidia.enable = config.dendrix.hasNvidia or false;
  # hardware.amd.enable = config.dendrix.hasAmd or false;
  # fileSystems."/" = { fsType = "btrfs"; } = config.dendrix.isBtrfs or false;
}
