{ config, pkgs, lib, ... }:

{
    home.username = "tortoise";
    home.homeDirectory = "/home/tortoise";
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      appimage-run
      bat
      bottom
      brightnessctl
      fastfetch
      fd
      filezilla
      gh
      gimp3-with-plugins
      git
      go
      guvcview
      jq
      kitty
      lm_sensors
      mullvad-vpn
      neovide
      nh
      nodejs_24
      obsidian
      orpie
      pinta
      ripgrep
      rpi-imager
      rpiboot
      screen
      sigil
      signal-desktop
      sops
      spotify
      tcl
      tidal-hifi
      tldr
      todoist-electron
      unzip
      v4l-utils
      via
      vivaldi
      zip

      # AI
      claude-code

      # Browsers
      firefox
      google-chrome

      # Desktop
      clipman
      grim
      hyprpicker
      hyprsunset
      impala
      kooha
      networkmanagerapplet
      slurp
      udiskie
      walker
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
      viu

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
      fira
      fira-code
      fira-code-symbols
      fira-mono
      font-awesome
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      atkinson-hyperlegible-next
      atkinson-hyperlegible-mono
      nerd-fonts.atkynson-mono
    ];

    fonts.fontconfig.enable = true;
    fonts.fontconfig.defaultFonts.monospace = [
      "Fira Code"
      "Noto Mono"
    ];
    fonts.fontconfig.defaultFonts.sansSerif = [
      "Atkinson Hyperlegible Next"
      "Noto Sans"
      "Fira Sans"
    ];
    fonts.fontconfig.defaultFonts.serif = [
      "Noto Serif"
    ];

    home.pointerCursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
      gtk.enable = true;
    };

    home.file."./.config/walker/themes/sleepy-turtle.css" = {
      source = ../../user-config/files/walker/sleepy-turtle.css;
    };

    home.file."./.config/walker/themes/sleepy-turtle.toml" = {
      source = ../../user-config/files/walker/sleepy-turtle.toml;
    };


    programs.forest = {
      enable = true;
      settings = {
        general = {
          baseDir = "${config.home.homeDirectory}/Projects";
          copy = [".env" ".envrc"];
          exec = [];
        };
      };
    };

    sops = {
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      secrets = {
        "git-config" = {
          sopsFile = ../../secrets/git-config;
          format = "binary";
        };
        "git-heyjobs-config" = {
          sopsFile = ../../secrets/git-heyjobs-config;
          format = "binary";
        };
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
      ../../user-config/ghostty.nix
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
      ../../user-config/sundial.nix
      ../../user-config/tmux.nix
      ../../user-config/vim.nix
      ../../user-config/waybar.nix
      ../../user-config/yazi.nix
      ../../user-config/zoxide.nix
      ../../user-config/zsh.nix
    ];
}
