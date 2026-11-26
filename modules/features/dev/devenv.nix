# devenv.sh
_: {
  flake.modules.homeManager.devenv =
    {
      lib,
      pkgs,
      ...
    }:
    {

      home.packages = [
        pkgs.devenv
      ];

      # Activation happens in-place via direnv (`use devenv` in each project's
      # .envrc): devenv 2.x's fish hook wraps the shell in a pty proxy that
      # hides agents from herdr and needed caller-pwd workarounds.
    };
}
