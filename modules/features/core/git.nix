# Git configuration aspect
{
  flake.modules.nixos.git = { pkgs, ... }: {
    programs.git.enable = true;
    programs.git.config = {
      user = {
        name = "ell0uz";
        email = "ell@ell0.uz";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    programs.git.lfs.enable = true;
  };

  flake.modules.homeManager.git = { pkgs, ... }: {
    programs.git.enable = true;
    programs.git.settings = {
      user = {
        name = "ell0uz";
        email = "ell@ell0.uz";
      };
    };
    programs.git.lfs.enable = true;
  };
}
