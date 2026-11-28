# Git configuration aspect
{
  flake.modules.homeManager.git = { pkgs, ... }: {
    home.packages = [ pkgs.gh ];
    programs.git = {
      enable = true;
      settings = {
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
}
