{
  flake.modules.nixos.shell = {
    # Use fish for default shell
    programs = {
      fish.enable = true;
      starship = {
        enable = true;
        # Works best with fish
        transientPrompt.enable = true;
      };
    };
  };

  flake.modules.homeManager.shell = {
    programs = {
      fish.enable = true;
      starship = {
        enable = true;
        # Works best with fish
        transientPrompt.enable = true;
      };
    };
  };
}
