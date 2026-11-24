# Shared Nix configuration aspect
{
  flake.modules.nixos.nix-settings = {
    nix.settings = {
      substituters = [
        "https://cache.xinux.uz?priority=30"
        "https://nix-community.cachix.org?priority=50"
        "https://numtide.cachix.org?priority=50"
        "https://cache.nixos.org?priority=40"
        "https://znixconfig.cachix.org?priority=50"
      ];
      trusted-public-keys = [
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "znixconfig.cachix.org-1:Z1kgO4W0MzLqquzRr9mU8kPv6kZh8Q5w48PROOFB1CM="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    nixpkgs.config.allowUnfree = true;
  };
}
