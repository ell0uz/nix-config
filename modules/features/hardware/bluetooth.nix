# Bluetooth TUI
{
  flake.modules.nixos.bluetooth =
    { config, lib, ... }:
    lib.mkIf (!config.dendrix.isWSL) {
      hardware.bluetooth.enable = true;
    };

  flake.modules.homeManager.bluetuith =
    { osConfig, lib, ... }:
    lib.mkIf (!osConfig.dendrix.isWSL) {
      programs.bluetuith.enable = true;
    };
}
