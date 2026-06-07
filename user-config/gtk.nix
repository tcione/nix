{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "mauve" ];
      };
    };
    gtk4.theme = null;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk3.extraCss = ''
      .view:selected,
      .view:selected:focus,
      .view:selected:hover,
      treeview.view:selected,
      iconview:selected,
      iconview:selected:focus,
      label:selected {
        color: #11111b;
      }
      .view:selected,
      .view:selected:focus,
      .view:selected:hover,
      treeview.view:selected,
      iconview:selected,
      iconview:selected:focus {
        background-color: shade(#cba6f7, 0.8);
      }
    '';
  };
}
