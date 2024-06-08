{ config, pkgs, ... }:

{
  services.hyprpaper.enable = true;
  services.hyprpaper.settings.splash = true;
  services.hyprpaper.settings.splash_offset = 2.0;
  services.hyprpaper.settings.ipc = "on";
  services.hyprpaper.settings.preload = [
    "~/Pictures/Backgrounds/flores.jpg"
    "~/Pictures/Backgrounds/waves1.jpg"
  ];
  services.hyprpaper.settings.wallpaper = [
    ",~/Pictures/Backgrounds/flores.jpg"
    ",~/Pictures/Backgrounds/waves1.jpg"
  ];
}
