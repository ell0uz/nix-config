{
  flake.modules.nixos.modules.power = {
    # This will save you money and possibly your life:
    services.thermald.enable = true;

    services.logind = {
      settings = {
        Login = {
          HandleLidSwitch = "suspend-then-hibernate";
          HandleLidSwitchDocked = "lock";
        };
      };
    };

    systemd.sleep.settings.Sleep = {
      HibernateDelaySec = "1h";
    };

    services.auto-cpufreq = {
      enable = true;
      settings = {};
    };

    # Dbus Service provding historical battery stats, access to external device batteries... etc.
    services.upower.enable = true;
  };
}
