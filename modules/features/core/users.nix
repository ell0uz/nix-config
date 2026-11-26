# User account aspect - creates primary user with wheel access
{
  flake.modules.nixos.users =
    {
      config,
      ...
    }:
    {
      # Set default root user
      users.users.root.initialPassword = "zero";
      # User is mandatory - create with dendrix username option
      users.users.${config.dendrix.userName} = {
        isNormalUser = true;
        group = "users";
        extraGroups = [ "wheel" ];
        # TODO: Learn about nixos-secrets to later put hashedPassword here
        initialPassword = "zero";
      };
    };
}
