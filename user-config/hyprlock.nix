{ config, pkgs, ... }:

{
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {
    general = {
      disable_loading_bar = true;
      grace = 15;
      hide_cursor = true;
      no_fade_in = false;
    };

    background = [
      {
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }
    ];

    input-field = [
      {
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "$text";
        inner_color = "$surface1";
        outer_color = "$accent";
        outline_thickness = 5;
        placeholder_text = "<span foreground=\"##cdd6f4\">Password...</span>";
        shadow_passes = 2;
      }
    ];
  };
}
