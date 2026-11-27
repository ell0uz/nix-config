{
  flake.modules.nixos.power = {
    # This will save you money and possibly your life:
    services = { config, lib, ...}: lib.mkIf (!config.dendrix.isWSL) {
      thermald.enable = true;

      logind = {
        settings = {
          Login = {
            HandleLidSwitch = "suspend-then-hibernate";
            HandleLidSwitchDocked = "lock";
          };
        };
      };

      auto-cpufreq = {
        enable = true;
        settings = { };
      };

      # Dbus Service provding historical battery stats, access to external device batteries... etc.
      upower.enable = true;
    };

    systemd.sleep.settings.Sleep = {
      HibernateDelaySec = "1h";
    };
  };
}
