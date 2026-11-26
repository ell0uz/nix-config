{
  flake.modules.nixos.kernel =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    lib.mkIf (!config.dendrix.isWSL) {
      # Kernel configuration set here
      boot.kernelPackages = pkgs.linuxPackages_latest;
    };
}
