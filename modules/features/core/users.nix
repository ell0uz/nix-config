# User account aspect - creates primary user with wheel access
{
  flake.modules.nixos.users =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      users.mutableUsers = false;
      # Set default root user
      users.users.root.hashedPasswordFile = config.age.secrets.user-password.path or null;
      # User is mandatory - create with dendrix username option
      users.users.${config.dendrix.userName} = {
        isNormalUser = true;
        group = "users";
        extraGroups = [ "wheel" ];
        shell = lib.mkIf config.programs.fish.enable pkgs.fish;
        hashedPasswordFile = config.age.secrets.user-password.path or null;
      };
    };
}
