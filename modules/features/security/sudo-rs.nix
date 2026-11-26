{
  flake.modules.nixos.sudo = {
    security.sudo.enable = false;
    security.sudo-rs.enable = true;
  };
}
