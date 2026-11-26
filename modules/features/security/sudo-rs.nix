{
  flake.modules.nixos.sudo = { config, lib, ... }: {
    # Disable sudo in order to not conflict with sudo-rs
    security.sudo.enable = false;

    security.sudo-rs = {
      enable = true;
      # Extra rules for WSL
      extraRules = lib.mkIf config.dendrix.isWSL [
        {
          groups = [ "wheel" ];
          commands = [
            {
              command = "ALL";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };
}
