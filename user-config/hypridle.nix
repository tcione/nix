{ config, pkgs, ... }:

{
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      before_sleep_cmd = "loginctl lock-session";
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      lock_cmd = "pidof hyprlock || hyprlock";
    };

    listener = [
      {
        timeout = 120;
        on-timeout = "brightnessctl -s set 10";
        on-resume = "brightnessctl -r";
      }
      {
        timeout = 120;
        on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
        on-resume = "brightnessctl -rd rgb:kbd_backlight";
      }
      {
        timeout = 180;
        on-timeout = "loginctl lock-session";
      }
      {
        timeout = 300;
        on-timeout = "hyprctl dispatch dpms off eDP-1";
        on-resume = "hyprctl dispatch dpms on eDP-1 && brightnessctl -r";
      }
      {
        timeout = 1800;
        on-timeout = "systemctl suspend";
        on-resume = "systemctl restart --user sundial";
      }
    ];
  };
}
