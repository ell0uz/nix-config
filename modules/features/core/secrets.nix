{ inputs, ... }: {
  flake.modules.nixos.secrets = { pkgs, ... }: {
    # Add agenix CLI for convenience
    environment.systemPackages = [ inputs.agenix.packages.${pkgs.system}.default ];
  };
}
