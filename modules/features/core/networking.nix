{
  flake.modules.nixos.networking =
    { config, lib, ... }:
    lib.mkIf (!config.dendrix.isWSL) {
      networking.networkmanager.enable = true;
      # Avoid 5s delay from NetworkManager-wait-online
      systemd.services.NetworkManager-wait-online.enable = false;
      users.users.${config.dendrix.userName}.extraGroups = [ "networkmanager" ];
    };
}
