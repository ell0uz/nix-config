{ lib, ... }: {
  options.dendrix = {
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "Hostname of this machine";
    };

    userName = lib.mkOption {
      type = lib.types.str;
      description = "User name for the primary user";
      default = "nixos";
    };

    stateVersion = lib.mkOption {
      type = lib.types.str;
      description = "NixOS state version for this host";
    };

    homeStateVersion = lib.mkOption {
      type = lib.types.str;
      description = "Home Manager state version for this host";
    };
  };
}
