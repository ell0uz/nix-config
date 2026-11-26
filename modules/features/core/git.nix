# Git configuration aspect
{
  flake.modules.nixos.git = {
    programs.git = {
      enable = true;
      config = {
        user = {
          name = "ell0uz";
          email = "ell@ell0.uz";
        };
        init.defaultBranch = "main";
        pull.rebase = true;
      };
      lfs.enable = true;
    };
  };

  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "ell0uz";
          email = "ell@ell0.uz";
        };
      };
      lfs.enable = true;
    };
  };
}
