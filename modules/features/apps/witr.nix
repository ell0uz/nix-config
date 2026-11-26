# Why is this running?
_: {
  flake.modules.homeManager.witr = { pkgs, ... }: {
    home.packages = [ pkgs.witr ];
  };
}
