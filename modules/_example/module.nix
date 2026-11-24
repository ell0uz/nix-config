{
  # Add lambda pattern if stuff like inputs, config, lib, pkgs is needed
  # {config, ...}: {...
  # Example module showing the dendritic pattern
  # Each module can contribute to multiple configuration classes

  # NixOS module
  flake.modules.nixos.my-feature =
    _: # If stuff like config or pkgs needed, just use {config, pkgs, ...}: instead of _:
    {
      # NixOS configuration for this feature
      # Example:
      # services.my-service.enable = true;
    };
  # Home Manager module
  flake.modules.homeManager.my-feature =
    _: # If stuff like config or pkgs needed, just use {config, pkgs, ...}: instead of _:
    {
      # Home Manager configuration for this feature
      # Example:
      # programs.my-program.enable = true;
    };

  # Optional: Darwin module (for macOS)
  # flake.modules.darwin.my-feature = { config, lib, pkgs, ... }: { ... };

  # Optional: Generic/shared module
  # flake.modules.generic.my-feature = { config, lib, pkgs, ... }: { ... };
}
