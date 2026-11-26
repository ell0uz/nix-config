{
  flake.modules.nixos.locale = {
    i18n = {
      defaultLocale = "en_US.UTF-8/UTF-8";
      supportedLocales = [ "en_US.UTF-8/UTF-8" ];
    };

    services.tzupdate = {
      enable = true;
      timer.enable = false;
    };
  };
}
