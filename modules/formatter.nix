{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = { pkgs, ... }: {
    projectRootFile = "flake.nix";
    programs = {
      nixfmt = {
        enable = true;
        package = pkgs.nixfmt-rs;
      };
      mdformat.enable = true;
      # prettier covers yaml + json (yamlfmt is not in nixpkgs)
      prettier.enable = true;
      shfmt.enable = true;
    };
    settings.excludes = [ "flake.lock" ];
  };
}
