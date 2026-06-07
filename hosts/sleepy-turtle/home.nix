{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "tortoise";
  home.homeDirectory = "/home/tortoise";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # rpi-imager
    # rpiboot

    appimage-run
    bat
    bottom
    brave
    devenv
    fastfetch
    fd
    filezilla
    gh
    gimp3-with-plugins
    go
    guvcview
    jq
    lm_sensors
    neovide
    nh
    nodejs_24
    obsidian
    orpie
    pinta
    rawtherapee
    ripgrep
    screen
    sigil
    signal-desktop
    sops
    tcl
    tidal-hifi
    tldr
    todoist-electron
    unzip
    v4l-utils
    zip
    zola

    # libreoffice

    # AI
    claude-code
    opencode
    pi
    # codex

    # Browsers
    google-chrome

    # Desktop
    grim
    hyprpicker
    hyprshutdown
    hyprsunset
    impala
    kooha
    satty
    slurp
    udiskie
    wl-clipboard

    # - Media
    evince
    font-manager
    libheif
    mpv
    pamixer
    playerctl
    pwvucontrol
    vimiv-qt
    viu

    # - Notifications
    libnotify

    # - GTK stuff
    adwaita-icon-theme
    catppuccin-cursors
    glib

    # - Fonts
    atkinson-hyperlegible-mono
    atkinson-hyperlegible-next
    fira
    fira-code
    fira-code-symbols
    fira-mono
    font-awesome
    nerd-fonts.atkynson-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
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

  home.sessionVariables.SSH_AUTH_SOCK = "${config.home.homeDirectory}/.1password/agent.sock";

  xdg.configFile."uwsm/env".text = ''
    export ADW_DISABLE_PORTAL=1
    export CLUTTER_BACKEND=wayland
    export ELECTRON_OZONE_PLATFORM_HINT=wayland
    export GTK_IM_MODULE=simple
    export MOZ_ENABLE_WAYLAND=1
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_QPA_PLATFORM=wayland;xcb
    export QT_QPA_PLATFORMTHEME=qt6ct
    export QT_STYLE_OVERRIDE=kvantum
    export QT_PLUGIN_PATH=${config.home.profileDirectory}/lib/qt-6/plugins
    export QML2_IMPORT_PATH=${config.home.profileDirectory}/lib/qt-6/qml
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export SDL_VIDEODRIVER=wayland
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_DESKTOP=Hyprland
    export XDG_SESSION_TYPE=wayland
    export XKB_DEFAULT_LAYOUT=us
    export XKB_DEFAULT_VARIANT=mac
    export _JAVA_AWT_WM_NONEREPARENTING=1
  '';

  imports = [
    ../../user-config/sops.nix
    ../../user-config/atuin.nix
    ../../user-config/chromium.nix
    ../../user-config/catppuccin.nix
    ../../user-config/nix-index.nix
    ../../user-config/dconf.nix
    ../../user-config/desktop-session-scripts.nix
    ../../user-config/direnv.nix
    ../../user-config/dunst.nix
    ../../user-config/eza.nix
    ../../user-config/firefox.nix
    ../../user-config/fzf.nix
    ../../user-config/ghostty.nix
    ../../user-config/git.nix
    ../../user-config/gtk.nix
    ../../user-config/hypridle.nix
    ../../user-config/hyprland.nix
    ../../user-config/hyprlock.nix
    ../../user-config/hyprpaper.nix
    ../../user-config/imv.nix
    ../../user-config/neovim.nix
    ../../user-config/qt.nix
    ../../user-config/starship.nix
    ../../user-config/sundial.nix
    ../../user-config/tmux.nix
    ../../user-config/vim.nix
    ../../user-config/walker.nix
    ../../user-config/waybar.nix
    ../../user-config/yazi.nix
    ../../user-config/zoxide.nix
    ../../user-config/zsh.nix
  ];
}
