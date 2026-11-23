{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs.nixfmt.enable = true;
    programs.mdformat.enable = true;
    # prettier covers yaml + json (yamlfmt is not in nixpkgs)
    programs.prettier.enable = true;
    programs.shfmt.enable = true;
    settings.excludes = [ "flake.lock" ];
  };
}
