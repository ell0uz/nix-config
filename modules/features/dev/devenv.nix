# devenv.sh
_: {
  flake.modules.homeManager.devenv =
    {
      lib,
      pkgs,
      ...
    }:
    {

      programs.devenv.enable = true;

      # Activation happens in-place via direnv (`use devenv` in each project's
      # .envrc): devenv 2.x's fish hook wraps the shell in a pty proxy that
      # hides agents from herdr and needed caller-pwd workarounds.
    };
}
