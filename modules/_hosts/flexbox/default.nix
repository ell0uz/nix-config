{ dendrix, inputs, ... }: {
  imports = [
    # Example: import a feature module
    # inputs.self.modules.nixos.some-feature
  ];

  # Use dendrix options
  networking.hostName = dendrix.hostname;

  # System configuration (required)
  nixpkgs.hostPlatform = "x86_64-linux";

  # State version
  system.stateVersion = dendrix.stateVersion;

  # Required: file system configuration
  fileSystems."/" = {
    fsType = "ext4";
    device = "/dev/disk/by-label/nixos";
  };

  # Required: boot loader configuration
  boot.loader.grub.devices = [ "/dev/sda" ];
  boot.loader.grub.enable = true;

  # User configuration
  users.users.farlion = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" ];
  };
}
