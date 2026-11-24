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
    environment.systemPackages = with pkgs; [ git-lfs ];
  };

  flake.modules.homeManager.git = { pkgs, ... }: {
    programs.git.enable = true;
    programs.git.user = {
      name = "ell0uz";
      email = "ell@ell0.uz";
    };
  };
}
