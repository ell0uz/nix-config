{ config, inputs, ... }:
let
  mkHost = import ./_lib/mkhost.nix { inherit config inputs; };
in
{
  # Host configurations - explicitly defined using mkHost
  flake.nixosConfigurations = {
    winpooter = mkHost {
      hostModule = ./_hosts/winpooter;
      dendrixConfig = {
        hostname = "winpooter";
        userName = "ell";
        stateVersion = "26.05";
        homeStateVersion = "26.05";
      };
    };
    # qwq = mkHost {
    #   hostModule = ./_hosts/qwq;
    #   dendrixConfig = {
    #     hostname = "qwq";
    #     userName = "qwq";
    #     stateVersion = "26.11";
    #     homeStateVersion = "26.11";
    #   };
    # };
  };
}
