{ lib, ... }: {
  # Temporary evaluation placeholder; replace/remove when hardware config is generated.
  fileSystems."/" = lib.mkDefault {
    device = "tmpfs";
    fsType = "tmpfs";
  };
}
