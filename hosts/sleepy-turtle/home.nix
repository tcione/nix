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
      deno
      fastfetch
      fd
      gh
      gimp
      git
      go
      kitty
      lm_sensors
      mullvad-vpn
      neovide
      nodejs_23
      obsidian
      orpie
      ripgrep
      screen
      signal-desktop
      spotify
      tcl
      tldr
      todoist-electron
      unzip
      via
      vivaldi
      zip
      v4l-utils
      guvcview
      sigil
      jq

      # Browsers
      firefox
      google-chrome

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

    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      dictionaries = [
        pkgs.hunspellDictsChromium.en_US
        pkgs.hunspellDictsChromium.de_DE
      ];
      extensions =
        let
          createChromiumExtensionFor = browserVersion: { id, sha256, version }:
            {
              inherit id;
              crxPath = builtins.fetchurl {
                url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
                name = "${id}.crx";
                inherit sha256;
              };
              inherit version;
            };
          createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
        in
          [
            (createChromiumExtension {
              # cookies autodelete
              id = "fhcgjolkccmbidfldomjliifgaodjagh";
              sha256 = "sha256:0bgd7k68wl3invdism0awjdxbdfbm1c7nimfzqhzmv2mvwr6059y";
              version = "3.8.2";
            })
            (createChromiumExtension {
              # ublock origin
              id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
              sha256 = "sha256:1lnk0k8zy0w33cxpv93q1am0d7ds2na64zshvbwdnbjq8x4sw5p6";
              version = "1.63.2";
            })
            (createChromiumExtension {
              # privacy badger
              id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";
              sha256 = "sha256:0iarnnzxxv77mg2adjmmmwhjxnlfl4xa6hczqyxczbikr87sn7yn";
              version = "2025.3.27";
            })
            (createChromiumExtension {
              # 1password
              id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";
              sha256 = "sha256:0yk3akkgq1r1dg0360bq0y4kgnnww8gvqa4lqnmwc4mkpwv6mkp4";
              version = "8.10.70.27";
            })
            (createChromiumExtension {
              # Lexical Dev Tools
              id = "kgljmdocanfjckcgfpcpdoklodllfdpc";
              sha256 = "sha256:0vx5iznxk5wwn3qfmqs8zayqv1mxyszzppbngy6yzqb9nzqc52b9";
              version = "0.16.0.0";
            })
            (createChromiumExtension {
              # Grammarly
              id = "kbfnbcaeplbcioakkpcpgfkobkghlhen";
              sha256 = "sha256:067pcfmgfndkbjbdlw3r5inx4ll4xqm2r8f6y99mnyz4isx9awsx";
              version = "14.1233.0";
            })
          ];
    };

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

    systemd.user.services = {
      sundial = {
        Unit.Description = "sets screen temperature based on time of the day";
        Service = {
          Type = "oneshot";
          ExecStart = toString (
          pkgs.writeShellScript "sundial-timer" ''
            #!/bin/bash

            set -eou pipefail

            BERLIN_LAT="52.5666644"
            BERLIN_LON="13.3999984"
            API_URL="https://api.sunrisesunset.io/json?lat=$BERLIN_LAT&lng=$BERLIN_LON&time_format=military"
            TZ_DATA=$(curl "$API_URL")
            TIME=$(date +%H%M)
            SUNRISE=$(echo "$TZ_DATA" | jq '.results | .sunrise')
            SUNSET=$(echo "$TZ_DATA" | jq '.results | .sunset')

            pkill -ef "hyprsunset -t" || true

            if [[ "$TIME" > "$SUNSET" ]] || [[ "$TIME" < "$SUNRISE" ]]; then
              hyprctl keyword exec "hyprsunset -t 2800"
            else
              hyprctl keyword exec "hyprsunset -t 6000"
            fi

            exit 0
          ''
          );
        };
        Install.WantedBy = [ "hyprland-session.target" ];
      };
    };

    systemd.user.timers = {
      sundialtimer = {
        Unit.Description = "timer for sundial service";
        Timer = {
          Unit = "sundial";
          OnBootSec = "1m";
          OnUnitActiveSec = "30m";
        };
        Install.WantedBy = [ "timers.target" ];
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
