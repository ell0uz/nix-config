{ inputs, ... }: {
  imports = [
    inputs.devenv.flakeModule
  ];

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
