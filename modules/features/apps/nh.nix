{
  flake.modules.homeManager.nh = {
    programs.nh = {
      enable = true;
      # TODO: Put flake path in the future
      # flake = "/home/ell/code/nixos-config";
    };
  };
}
