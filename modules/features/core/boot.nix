{ config, lib, ... }:
lib.mkIf (!config.dendrix.isWSL) {
  flake.modules.nixos.boot = {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          memtest86.enable = true;
        };
        efi.canTouchEfiVariables = true;
      };
      consoleLogLevel = "7";

      initrd.systemd.enable = true;
    };
  };
}
