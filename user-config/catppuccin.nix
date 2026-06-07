{ config, pkgs, ... }:

{
  catppuccin = {
    enable = true;
    autoEnable = false;
    flavor = "mocha";
    accent = "mauve";

    hyprlock = {
      enable = true;
      useDefaultConfig = false;
    };
    gtk.icon.enable = true;
    fzf.enable = true;
    starship.enable = true;
    yazi.enable = true;
    imv.enable = true;
  };
}
