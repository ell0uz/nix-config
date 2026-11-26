{
  flake.modules.nixos.sudo = { config, lib, ... }: {
    # Disable sudo in order to not conflict with sudo-rs
    security.sudo.enable = false;

    security.sudo-rs = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          commands = [ "ALL" ];
          options = [ "NOPASSWD" ];
        }
      ];
    };
  };
}
