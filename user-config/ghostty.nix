{ config, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    package = if pkgs.stdenv.isDarwin then null else pkgs.ghostty;
    settings = {
      theme = "catppuccin-mocha";
      font-family = "Fira Code Medium";
      font-size = if pkgs.stdenv.isDarwin then 16 else 12;
      font-feature = "+ss01 +ss02 +ss03 +ss04 +ss05 +ss07 +ss08 +zero +onum +calt";
      window-padding-x = 2;
      window-padding-y = 2;
      cursor-style = "block";
      cursor-text = "#222222";
      cursor-style-blink = false;
      window-theme = "ghostty";
      keybind = [
        "shift+enter=text:\n"
        "ctrl+shift+|=new_split:right"
        "ctrl+shift+_=new_split:down"
        "ctrl+shift+h=goto_split:left"
        "ctrl+shift+j=goto_split:down"
        "ctrl+shift+k=goto_split:up"
        "ctrl+shift+l=goto_split:right"
        "ctrl+shift+m=toggle_split_zoom"
      ];
    };
  };
}
