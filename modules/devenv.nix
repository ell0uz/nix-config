{ inputs, ... }: {
  imports = [
    inputs.devenv.flakeModule
  ];

  perSystem.devenv.shells = { pkgs, ... }: {
    # create devShells.default
    default = {
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
