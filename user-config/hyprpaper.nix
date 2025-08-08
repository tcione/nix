{ config, pkgs, ... }:

{
  services.hyprpaper.enable = true;
  services.hyprpaper.settings.splash = false;
  services.hyprpaper.settings.splash_offset = 2.0;
  services.hyprpaper.settings.ipc = "on";
  services.hyprpaper.settings.preload = [
    "~/Pictures/Backgrounds/a_cat_in_a_cup.png"
    "~/Pictures/Backgrounds/a_cartoon_of_a_island_with_a_bridge_and_trees_01.jpg"
  ];
  services.hyprpaper.settings.wallpaper = [
    ",~/Pictures/Backgrounds/a_cartoon_of_a_island_with_a_bridge_and_trees_01.jpg"
  ];
}
