{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$rosewater" = "0xfff5e0dc";
    "$flamingo" = "0xfff2cdcd";
    "$pink" = "0xfff5c2e7";
    "$mauve" = "0xffcba6f7";
    "$red" = "0xfff38ba8";
    "$maroon" = "0xffeba0ac";
    "$peach" = "0xfffab387";
    "$green" = "0xffa6e3a1";
    "$teal" = "0xff94e2d5";
    "$sky" = "0xff89dceb";
    "$sapphire" = "0xff74c7ec";
    "$blue" = "0xff89b4fa";
    "$lavender" = "0xffb4befe";
    "$text" = "0xffcdd6f4";
    "$subtext1" = "0xffbac2de";
    "$subtext0" = "0xffa6adc8";
    "$overlay2" = "0xff9399b2";
    "$overlay1" = "0xff7f849c";
    "$overlay0" = "0xff6c7086";
    "$surface2" = "0xff585b70";
    "$surface1" = "0xff45475a";
    "$surface0" = "0xff313244";
    "$base" = "0xff1e1e2e";
    "$mantle" = "0xff181825";
    "$crust" = "0xff11111b";
    "$mod" = "SUPER";
    exec-once = [
      "dunst"
      "blueman-applet"
      "/etc/polkit-gnome-authentication-agent-1"
      "wl-paste -t text --watch clipman store --no-persist"
      "wl-paste -t image --watch clipman store --no-persist"
      "udiskie &"
      "systemctl --user start waybar"
      "systemctl --user start sunset"
      "1password --silent --disable-gpu-compositing"
    ];
    env = [
      "SDL_VIDEODRIVER,wayland"
      "MOZ_ENABLE_WAYLAND,1"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "SDL_VIDEODRIVER,wayland"
      "_JAVA_AWT_WM_NONEREPARENTING,1"
      "CLUTTER_BACKEND,\"wayland\""
    ];
    bind = [
      "$mod, Return, exec, kitty"
      "$mod, Q, killactive,"
      "$mod, E, exec, thunar"
      "$mod, Space, togglefloating,"
      "$mod, M, fullscreen, 1"
      "$mod, F, fullscreen, 0"
      "$mod, D, exec, wofi"
      "$mod SHIFT, D, exec, wofi --show run"
      "$mod, T, togglesplit, # dwindle"
      "$mod, V, exec, clipman pick -t wofi"
      "$mod, C, exec, hyprpicker --autocopy --format=hex"
      "$mod, h, movefocus, l"
      "$mod, l, movefocus, r"
      "$mod, k, movefocus, u"
      "$mod, j, movefocus, d"
      "$mod SHIFT, h, movewindow, l"
      "$mod SHIFT, l, movewindow, r"
      "$mod SHIFT, k, movewindow, u"
      "$mod SHIFT, j, movewindow, d"
      "$mod , minus , togglespecialworkspace,"
      "$mod SHIFT, minus , movetoworkspace , special"
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
      "$mod, TAB, cyclenext"
      "$mod SHIFT, TAB, exec, hyprctl dispatch focusurgentorlast"
      "$mod, P, exec , grim -t jpeg ~/Pictures/$(date +%Y-%m-%d_%H-%m-%s).jpg"
      "$mod SHIFT, P , exec , grim -t jpeg -g \"$(slurp)\" ~/Pictures/$(date +%Y-%m-%d_%H-%m-%s).jpg"
      "$mod SHIFT, BackSpace, exec, ~/.local/bin/power-menu.sh"
      ", XF86MonBrightnessUp , exec , light -T 1.4 && notify-send -h int:value:$(light -G) \" Brightness\""
      "SHIFT , XF86MonBrightnessUp , exec , light -A 1 && notify-send -h int:value:$(light -G) \" Brightness\""
      ", XF86MonBrightnessDown , exec , light -T 0.72 && notify-send -h int:value:$(light -G) \" Brightness\""
      "SHIFT , XF86MonBrightnessDown , exec , light -U 1 && notify-send -h int:value:$(light -G) \" Brightness\""
      ", XF86AudioRaiseVolume , exec , pamixer -i 5 && notify-send -h int:value:$(pamixer --get-volume) \"  Volume\""
      ", XF86AudioLowerVolume , exec , pamixer -d 5 && notify-send -h int:value:$(pamixer --get-volume) \"  Volume\""
      "ALT, XF86AudioRaiseVolume , exec , pamixer -i 1 && notify-send -h int:value:$(pamixer --get-volume) \"  Volume\""
      "ALT, XF86AudioLowerVolume , exec , pamixer -d 1 && notify-send -h int:value:$(pamixer --get-volume) \"  Volume\""
      ", XF86AudioMute , exec , ~/.local/bin/hyprland-mute.sh"
      "SHIFT, XF86AudioRaiseVolume , exec , dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
      "SHIFT, XF86AudioLowerVolume , exec , dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
      "SHIFT, XF86AudioMute , exec , dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
      ", XF86AudioPlay , exec , dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
      ", XF86AudioNext , exec , dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
      ", XF86AudioPrev , exec , dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
    ]
    ++ (
      builtins.concatLists(builtins.genList(
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        ]
      ) 10)
    );
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    monitor = [
      ", highres, auto, 1"
      # "eDP-1, highres, auto, 2"
      "eDP-1, 2880x1920@60, auto, 2"
      "DP-1, 2560x1440@120, auto, 1"
    ];
    workspace = [
      "1, monitor:DP-1, default: true"
      "2, monitor:DP-1"
      "3, monitor:DP-1"
      "4, monitor:DP-1"
      "5, monitor:DP-1"
    ];
    input.repeat_delay = 350;
    input.repeat_rate = 100;
    input.kb_layout = "us";
    input.kb_variant = "mac";
    input.kb_model = "";
    input.kb_options = "lv3:rwin_switch,ctrl:nocaps";
    input.kb_rules = "";
    input.follow_mouse = 1;
    input.touchpad.natural_scroll = "no";
    input.touchpad.scroll_factor = 1;
    input.touchpad.tap-to-click = false;
    input.sensitivity = 0;
    general.gaps_in = 2;
    general.gaps_out = 2;
    general.border_size = 1;
    general."col.active_border" = "rgba(ff89b4aa)";
    general."col.inactive_border" = "rgba(595959aa)";
    general.layout = "dwindle";
    decoration.rounding = 10;
    decoration.inactive_opacity = 1.0;
    animations.enabled = "yes";
    animations.bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
    animation = [
      "windows, 1, 7, myBezier"
      "windowsOut, 1, 7, default, popin 80%"
      "border, 1, 10, default"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
    dwindle.pseudotile = "yes";
    dwindle.preserve_split = "yes";
    gestures.workspace_swipe = "off";
    windowrulev2 = [
      "workspace 5 silent,class:^signal$"
      "workspace 6 silent,title:^Spotify$"

      # Paypal popup window
      "float,title:^(.*?Log in to your Paypal account)$"
      "center,title:^(.*?Log in to your Paypal account)$"

      # Google meets indicator
      "float,title:^(.*?Sharing Indicator)$"
      "move 100%-122 100%-42,title:^(.*?Sharing Indicator)$"
      "size 110 30,title:^(.*?Sharing Indicator)$"

      # Fastfetch data
      "float,class:^tui(btm|fastfetch)$"
      "center,class:^tui(btm|fastfetch)$"
    ];
  };
}
