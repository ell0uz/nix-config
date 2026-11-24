# Nix-ld aspect - enables nix-ld for dynamic linker configuration
{
  flake.modules.nixos.nix-ld = {
    programs.nix-ld.enable = true;
  };
}
