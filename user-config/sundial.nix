{ config, pkgs, ... }:

{
  services.sundial = {
    enable = true;
    logLevel = "debug";
    interval = "*:0/1";
    settings = {
      location = {
        mode = "auto";
        latitude = "52.56";
        longitude = "13.39";
      };
      screen = {
        day_temperature = "6000";
        day_gamma = "100";
        night_temperature = "2800";
        night_gamma = "80";
        fade_duration_in_minutes = 60;
      };
      cache.enabled = true;
    };
  };
}
