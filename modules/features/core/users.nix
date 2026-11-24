# User account aspect - creates primary user with wheel access
{
  flake.modules.nixos.users =
    {
      config,
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
