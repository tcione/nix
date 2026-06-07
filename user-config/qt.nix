{ config, pkgs, ... }:

let
  kvantumTheme = "catppuccin-mocha-mauve";

  # Catppuccin Mocha palette mapped onto qt6ct's 21 QPalette roles, in order:
  # WindowText, Button, Light, Midlight, Dark, Mid, Text, BrightText, ButtonText,
  # Base, Window, Shadow, Highlight, HighlightedText, Link, LinkVisited,
  # AlternateBase, ToolTipBase, ToolTipText, PlaceholderText, Accent.
  mochaActive = "#ffcdd6f4, #ff313244, #ff585b70, #ff45475a, #ff11111b, #ff313244, #ffcdd6f4, #fff5e0dc, #ffcdd6f4, #ff1e1e2e, #ff1e1e2e, #ff11111b, #ffcba6f7, #ff11111b, #ff89b4fa, #ffcba6f7, #ff181825, #ff313244, #ffcdd6f4, #ff6c7086, #ffcba6f7";
  mochaDisabled = "#ff6c7086, #ff313244, #ff585b70, #ff45475a, #ff11111b, #ff313244, #ff6c7086, #fff5e0dc, #ff6c7086, #ff1e1e2e, #ff1e1e2e, #ff11111b, #ff313244, #ff6c7086, #ff89b4fa, #ffcba6f7, #ff181825, #ff313244, #ffcdd6f4, #ff6c7086, #ffcba6f7";
in
{
  home.packages = with pkgs; [
    qt6Packages.qt6ct
    qt6Packages.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      variant = "mocha";
      accent = "pink";
    })
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=${kvantumTheme}
  '';

  xdg.configFile."qt6ct/colors/catppuccin-mocha.conf".text = ''
    [ColorScheme]
    active_colors=${mochaActive}
    inactive_colors=${mochaActive}
    disabled_colors=${mochaDisabled}
  '';

  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    style=kvantum
    custom_palette=true
    color_scheme_path=${config.xdg.configHome}/qt6ct/colors/catppuccin-mocha.conf
    standard_dialogs=default
  '';
}
