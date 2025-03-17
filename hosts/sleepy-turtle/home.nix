{ config, pkgs, ... }:

{
    home.username = "tortoise";
    home.homeDirectory = "/home/tortoise";
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      appimage-run
      bat
      bottom
      fastfetch
      fd
      gh
      gimp
      git
      kitty
      lm_sensors
      neovide
      obsidian
      orpie
      ripgrep
      signal-desktop
      spotify
      tcl
      tldr
      todoist-electron
      unzip
      via
      zip
      mullvad-vpn

      # Browsers
      firefox
      google-chrome
      ungoogled-chromium

      # Desktop
      clipman
      grim
      hyprpicker
      hyprsunset
      kooha
      networkmanagerapplet
      slurp
      udiskie
      wl-clipboard

      # - Media
      evince
      font-manager
      libheif
      mpv
      pamixer
      pavucontrol
      playerctl
      vimiv-qt

      # - Notifications
      libnotify

      # - GTK stuff
      catppuccin-cursors
      catppuccin-gtk
      glib
      adwaita-icon-theme

      # - File manager
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      xfce.thunar-volman
      xfce.tumbler
      xfce.xfconf

      # - Fonts
      dejavu_fonts
      fira
      fira-code
      fira-code-symbols
      fira-mono
      font-awesome
      liberation_ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto-slab
      ubuntu_font_family
    ];

    fonts.fontconfig.enable = true;
    fonts.fontconfig.defaultFonts.monospace = [
      "Fira Code"
      "DejaVu Sans Mono"
      "Noto Mono"
    ];
    fonts.fontconfig.defaultFonts.sansSerif = [
      "Fira Sans"
      "Ubuntu"
      "DejaVu Sans"
      "Noto Sans"
    ];
    fonts.fontconfig.defaultFonts.serif = [
      "Roboto Slab"
      "Liberation Serif"
      "Noto Serif"
    ];

    home.pointerCursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
      gtk.enable = true;
    };

    systemd.user.services.sunset = {
      Unit = {
        Description = "Set screen temperature based on time of the day.";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.writeShellScript "sunset" ''
          #!/bin/bash

          while true; do
            HOUR=$(date +%H)

            if [[ $HOUR -ge "07" && $HOUR -le "18" ]]; then
              ${pkgs.hyprsunset} -t 6000 > /dev/null 2>&1 &
            else
              ${pkgs.hyprsunset} -t 2800 > /dev/null 2>&1 &
            fi

            sleep 3600
          done;
        ''}";
      };
    };

    imports = [
      ../../user-config/command-not-found.nix
      ../../user-config/dconf.nix
      ../../user-config/desktop-session-scripts.nix
      ../../user-config/direnv.nix
      ../../user-config/dunst.nix
      ../../user-config/eza.nix
      ../../user-config/fzf.nix
      ../../user-config/git.nix
      ../../user-config/gtk.nix
      ../../user-config/hypridle.nix
      ../../user-config/hyprland.nix
      ../../user-config/hyprlock.nix
      ../../user-config/hyprpaper.nix
      ../../user-config/imv.nix
      ../../user-config/kitty.nix
      ../../user-config/neovim.nix
      ../../user-config/starship.nix
      ../../user-config/tmux.nix
      ../../user-config/vim.nix
      ../../user-config/waybar.nix
      ../../user-config/wofi.nix
      ../../user-config/yazi.nix
      ../../user-config/zoxide.nix
      ../../user-config/zsh.nix
    ];
}
