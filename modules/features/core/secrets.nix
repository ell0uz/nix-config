{ self, inputs, ... }: {
  flake.modules.nixos.secrets = { pkgs, ... }: {
    age = {
      identityPaths = [ "/home/ell/.ssh/id_ed25519" "/home/nixos/.ssh/id_ed25519" ];
      secrets.user-password = {
        file = "${self.outPath}/secrets/mpassword.age";
        mode = "0400";
        owner = "root";
        group = "root";
      };
    };
    # Add agenix CLI for convenience
    environment.systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
  };
}
