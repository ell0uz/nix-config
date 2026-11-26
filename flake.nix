{
  description = "Nix configuration";

  nixConfig = {
    # substituters = [
    #   "https://cache.xinux.uz?priority=30"
    #   "https://nix-community.cachix.org?priority=50"
    #   "https://numtide.cachix.org?priority=50"
    #   "https://cache.nixos.org?priority=40"
    #   "https://devenv.cachix.org?priority=50"
    #   "https://ell-nixos-config.cachix.org?priority=31"
    # ];
    # trusted-public-keys = [
    #   "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
    #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    #   "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    #   "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    #   "ell-nixos-config.cachix.org-1:7MA/IeHeeLTUSLzYWkPCe37NHp/DOUmESe5bry+pit8="
    # ];
    # experimental-features = [
    #   "nix-command"
    #   "flakes"
    # ];
  };

  inputs = {
    ###############
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";

    ###############
    # flake-parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };

    ###############
    # import-tree
    import-tree.url = "github:denful/import-tree";

    ###############
    # treefmt-nix
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ###############
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ###############
    # determinate
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    ###############
    # flake-compat
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    ###############
    # nur
    nur = {
      url = "github:nix-community/nur";
      inputs.flake-parts.follows = "flake-parts";
    };

    ###############
    # nixos-wsl
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    ###############
    # disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ###############
    # devenv
    devenv = {
      url = "github:cachix/devenv";
      inputs = {
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
        rust-overlay.follows = "rust-overlay";
      };
    };

    ###############
    # rust-overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ###############
    # git-hooks
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
