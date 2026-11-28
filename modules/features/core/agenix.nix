{ inputs, ... }: {
  flake.modules.nixos.agenix = { config, ... }: {
    environment.systemPackages = [ inputs.agenix.packages.${config.dendrix.system}.default ];
  };
}
