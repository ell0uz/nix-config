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

    hasNvidia = lib.mkOption {
      type = lib.types.bool;
      description = "Whether this machine has an NVIDIA GPU";
      default = false;
    };

    isWSL = lib.mkOption {
      type = lib.types.bool;
      description = "Whether this machine is running under WSL";
      default = false;
    };

    system = lib.mkOption {
      type = lib.types.str;
      description = "System architecture for this host";
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
