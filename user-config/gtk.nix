{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark-solid";
      package = pkgs.whitesur-gtk-theme.override {
        altVariants = [ "normal" ];
        colorVariants = [ "Dark" ];
        opacityVariants = [ "solid" ];
        themeVariants = [ "default" ];
      };
    };
    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
