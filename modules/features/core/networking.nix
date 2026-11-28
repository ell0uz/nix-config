{
  flake.modules.nixos.networking =
    { config, lib, ... }:
    lib.mkIf (!config.dendrix.isWSL) {
      networking.networkmanager.enable = true;
      users.users.${config.dendrix.userName}.extraGroups = [ "networkmanager" ];
    };
}
