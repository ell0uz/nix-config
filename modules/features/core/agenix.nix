{ inputs, ... }: {
  flake.modules.nixos.agenix = { pkgs, ... }: {
    environment.systemPackages = [ inputs.agenix.packages.${pkgs.system}.default ];
  };
}
