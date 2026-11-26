{ inputs, ... }: {
  imports = [
    inputs.devenv.flakeModule
  ];

  # IMPORTANT: To use this shell
  # use this command:
  # nix develop --no-pure-eval
  # https://devenv.sh/guides/using-with-flake-parts/#entering-the-shell
  perSystem.devenv.shells = {
    # create devShells.default
    default = { pkgs, ... }: {
      languages.nix = {
        enable = true;
        lsp = {
          enable = true;
          package = pkgs.nixd;
        };
      };
    };
  };
}
