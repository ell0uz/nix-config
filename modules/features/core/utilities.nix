# System utilities aspect
{
  flake.modules.nixos.utilities = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      curl
      wget
    ];
  };

  flake.modules.homeManager.utilities = { pkgs, ... }: {
    home.packages = with pkgs; [
      just
    ];
  };
}
