{
  flake.modules.nixos.btop = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.btop
    ];
  };
  flake.modules.homeManager.btop = {
    programs.btop.enable = true;
  };
}
