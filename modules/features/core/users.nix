# User account aspect - creates primary user with wheel access
{ inputs, lib, ... }:
{
  flake.modules.nixos.users =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # User is mandatory - create with dendrix username option
      users.users.${config.dendrix.userName} = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };
    };
}
