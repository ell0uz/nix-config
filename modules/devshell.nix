{ inputs, ... }: {
  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem.devshells = {
    default = { pkgs, ... }: {
      devshell = {
        name = "default";
        packages = with pkgs; [
          statix
          deadnix
          vulnix
          just
          cachix
        ];
      };
    };
  };
}
