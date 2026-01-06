{ config, pkgs, ... }:

{
  services.hyprpaper.enable = true;
  services.hyprpaper.settings.splash = false;
  services.hyprpaper.settings.splash_offset = 2.0;
  services.hyprpaper.settings.ipc = true;
  services.hyprpaper.settings.wallpaper = [
    {
      monitor = "";
      path = "~/Pictures/Backgrounds/a_cartoon_of_a_island_with_a_bridge_and_trees_01.jpg";
      fit_mode = "cover";
    }
  ];
}
