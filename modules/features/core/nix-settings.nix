# Shared Nix configuration aspect
{
  flake.modules.nixos.nix-settings = {
    nix.settings = {
      substituters = [
        "https://cache.nixos.org?priority=40"
        "https://cache.xinux.uz?priority=30"
        "https://ell-nixos-config.cachix.org?priority=31"
        "https://nix-community.cachix.org?priority=50"
        "https://numtide.cachix.org?priority=50"
        "https://devenv.cachix.org?priority=50"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
        "ell-nixos-config.cachix.org-1:7MA/IeHeeLTUSLzYWkPCe37NHp/DOUmESe5bry+pit8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    nixpkgs.config.allowUnfree = true;
  };
}
