{
  description = "Nix configuration";

  nixConfig = {
    # substituters = [
    #   "https://cache.xinux.uz?priority=30"
    #   "https://nix-community.cachix.org?priority=50"
    #   "https://numtide.cachix.org?priority=50"
    #   "https://cache.nixos.org?priority=40"
    # ];
    # trusted-public-keys = [
    #   "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
    #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    #   "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
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
    # nur
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    imports = [
      (inputs.import-tree ./modules)
    ];
  };
}
