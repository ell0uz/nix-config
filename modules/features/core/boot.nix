{
  flake.modules.nixos.boot = { config, lib, ... }: lib.mkIf (!config.dendrix.isWSL) {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          memtest86.enable = true;
        };
        efi.canTouchEfiVariables = true;
      };
      consoleLogLevel = 7;

      initrd.systemd.enable = true;
    };
  };
}
