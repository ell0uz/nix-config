{
  description = "Nix configuration";

nixConfig = {
  # Keep cache.nixos.org and add the Nix community cache for this flake.
  extra-substituters = [ "https://nix-community.cachix.org" ];
  # Nix may prompt before trusting these flake-local settings.
  extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
};

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt;
        };
    };
}
