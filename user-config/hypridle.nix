{ config, pkgs, ... }:

{
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      lock_cmd = "hyprlock";
    };

    listener = [
      {
        timeout = 180;
        on-timeout = "hyprlock";
      }
      {
        timeout = 300;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
    ];
  };
}
