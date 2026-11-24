# WSL host configuration - aspects auto-included from modules/features/
{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = config.dendrix.userName;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.hostName = config.dendrix.hostname;
  system.stateVersion = config.dendrix.stateVersion;

  # User account and Nix settings are now provided by auto-included aspects:
  # - modules/features/core/users.nix -> flake.modules.nixos.users
  # - modules/features/core/nix-settings.nix -> flake.modules.nixos.nix-settings
}
