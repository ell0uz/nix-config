# Git configuration aspect
{
  flake.modules.nixos.git = { pkgs, ... }: {
    programs.git.enable = true;
  };

  flake.modules.homeManager.git = { pkgs, ... }: {
    programs.git.enable = true;
  };
}
