{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = { pkgs, ... }: {
    projectRootFile = "flake.nix";
    programs.nixfmt={
      enable = true;
      package = pkgs.nixfmt-rs;
    };
    programs.mdformat.enable = true;
    # prettier covers yaml + json (yamlfmt is not in nixpkgs)
    programs.prettier.enable = true;
    programs.shfmt.enable = true;
    settings.excludes = [ "flake.lock" ];
  };
}
