{ config, inputs, ... }: {
  imports = [
    # Example: import a feature module
    # inputs.self.modules.nixos.some-feature
  ];

  # Use dendrix options
  networking.hostName = config.dendrix.hostname;

  # System configuration (required)
  nixpkgs.hostPlatform = "x86_64-linux";

  # State version
  system.stateVersion = config.dendrix.stateVersion;

  # Required: file system configuration
  fileSystems."/" = {
    fsType = "ext4";
    device = "/dev/disk/by-label/nixos";
  };

  # Required: boot loader configuration
  boot.loader.grub.devices = [ "/dev/sda" ];
  boot.loader.grub.enable = true;

  # User configuration - using dendrix.userName dynamically
  # Note: We define users.users here, and hosts.nix defines home-manager.users
  users.users.${config.dendrix.userName} = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" ];
  };
}
