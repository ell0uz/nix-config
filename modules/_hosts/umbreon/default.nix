{ config, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.hostPlatform = config.dendrix.system;
  networking.hostName = config.dendrix.hostname;
  system.stateVersion = config.dendrix.stateVersion;
}
