{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      font-family = "Fira Code Medium";
      font-size = 12;
      font-feature = "+ss01 +ss02 +ss03 +ss04 +ss05 +ss07 +ss08 +zero +onum +calt";
      window-padding-x = 2;
      window-padding-y = 2;
      cursor-style = "block";
      cursor-text = "#222222";
      cursor-style-blink = false;
      window-theme = "ghostty";
    };
  };
}
