{ config, lib, pkgs, ... }:

let
  inline = lib.generators.mkLuaInline;

  modBind = keys: action: {
    _args = [
      (inline ''mod .. " + ${keys}"'')
      (inline action)
    ];
  };

  rawBind = keys: action: {
    _args = [
      keys
      (inline action)
    ];
  };

  workspaceBinds = builtins.concatLists (
    builtins.genList (x:
      let wsId = toString (x + 1);
      in [
        {
          _args = [
            (inline ''mod .. " + ${wsId}"'')
            (inline "hl.dsp.focus({ workspace = ${wsId} })")
          ];
        }
        {
          _args = [
            (inline ''mod .. " + SHIFT + ${wsId}"'')
            (inline "hl.dsp.window.move({ workspace = ${wsId} })")
          ];
        }
      ]
    ) 9
  );
in

{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.configType = "lua";
  wayland.windowManager.hyprland.settings = {
    mod = {
      _var = "SUPER";
    };

    config = {
      input = {
        repeat_delay = 350;
        repeat_rate = 100;
        kb_layout = "us";
        kb_variant = "mac";
        kb_options = "lv3:rwin_switch,ctrl:nocaps";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
          scroll_factor = 1;
          tap_to_click = false;
        };
      };
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 1;
        col = {
          active_border = "rgba(ff89b4aa)";
          inactive_border = "rgba(595959aa)";
        };
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
        inactive_opacity = 1.0;
        shadow.enabled = false;
      };
      animations.enabled = true;
      dwindle.preserve_split = true;
    };

    env = [
      { _args = [ "CLUTTER_BACKEND" "wayland" ]; }
      { _args = [ "ELECTRON_OZONE_PLATFORM_HINT" "wayland" ]; }
      { _args = [ "MOZ_ENABLE_WAYLAND" "1" ]; }
      { _args = [ "QT_AUTO_SCREEN_SCALE_FACTOR" "1" ]; }
      { _args = [ "QT_QPA_PLATFORM" "wayland;xcb" ]; }
      { _args = [ "QT_QPA_PLATFORMTHEME" "qt5ct" ]; }
      { _args = [ "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1" ]; }
      { _args = [ "SDL_VIDEODRIVER" "wayland" ]; }
      { _args = [ "XDG_CURRENT_DESKTOP" "Hyprland" ]; }
      { _args = [ "XDG_SESSION_DESKTOP" "Hyprland" ]; }
      { _args = [ "XDG_SESSION_TYPE" "wayland" ]; }
      { _args = [ "XKB_DEFAULT_LAYOUT" "us" ]; }
      { _args = [ "XKB_DEFAULT_VARIANT" "mac" ]; }
      { _args = [ "_JAVA_AWT_WM_NONEREPARENTING" "1" ]; }
      { _args = [ "GTK_IM_MODULE" "simple" ]; }
    ];

    monitor = [
      { output = ""; mode = "highres"; position = "auto"; scale = 1; }
      { output = "eDP-1"; mode = "2880x1920@60"; position = "auto"; scale = 2; }
      { output = "DP-1"; mode = "2560x1440@120"; position = "auto"; scale = 1; }
      { output = "DP-2"; mode = "2560x1440@120"; position = "auto"; scale = 1; }
    ];

    workspace_rule = [
      { workspace = "1"; monitor = "DP-1"; default = true; }
      { workspace = "2"; monitor = "DP-1"; }
      { workspace = "3"; monitor = "DP-1"; }
      { workspace = "4"; monitor = "DP-1"; }
      { workspace = "5"; monitor = "DP-1"; }
      { workspace = "6"; monitor = "eDP-1"; }
      { workspace = "7"; monitor = "eDP-1"; }
      { workspace = "8"; monitor = "eDP-1"; }
      { workspace = "9"; monitor = "eDP-1"; }
    ];

    animation = [
      { leaf = "windowsOut"; enabled = true; speed = 7; bezier = "default"; style = "popin 80%"; }
      { leaf = "border"; enabled = true; speed = 10; bezier = "default"; }
      { leaf = "fade"; enabled = true; speed = 7; bezier = "default"; }
      { leaf = "workspaces"; enabled = true; speed = 6; bezier = "default"; }
    ];

    bind = [
      (modBind "Return" ''hl.dsp.exec_cmd("ghostty")'')
      (modBind "Q" "hl.dsp.window.close()")
      (modBind "E" ''hl.dsp.exec_cmd("thunar")'')
      (modBind "Space" ''hl.dsp.window.float({ action = "toggle" })'')
      (modBind "M" ''function() hl.window.fullscreen({ action = "toggle", mode = "maximized" }) end'')
      (modBind "F" ''function() hl.window.fullscreen({ action = "toggle", mode = "fullscreen" }) end'')
      (modBind "D" ''hl.dsp.exec_cmd("walker")'')
      (modBind "B" ''hl.dsp.exec_cmd("brave")'')
      (modBind "V" ''hl.dsp.exec_cmd("clipman pick -t custom -T 'walker --dmenu'")'')
      (modBind "C" ''hl.dsp.exec_cmd("hyprpicker --autocopy --format=hex")'')

      (modBind "h" ''hl.dsp.focus({ direction = "left" })'')
      (modBind "l" ''hl.dsp.focus({ direction = "right" })'')
      (modBind "k" ''hl.dsp.focus({ direction = "up" })'')
      (modBind "j" ''hl.dsp.focus({ direction = "down" })'')

      (modBind "SHIFT + h" ''hl.dsp.window.move({ direction = "left" })'')
      (modBind "SHIFT + l" ''hl.dsp.window.move({ direction = "right" })'')
      (modBind "SHIFT + k" ''hl.dsp.window.move({ direction = "up" })'')
      (modBind "SHIFT + j" ''hl.dsp.window.move({ direction = "down" })'')

      (modBind "mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'')
      (modBind "mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'')
      (modBind "TAB" "hl.dsp.window.cycle_next()")
      (modBind "SHIFT + TAB" ''function() hl.dispatch("focusurgentorlast") end'')

      # Special spaces
      (modBind "minus" ''function() hl.dispatch("togglespecialworkspace") end'')
      (modBind "SHIFT + minus" ''hl.dsp.window.move({ workspace = "special" })'')
      (modBind "ALT + t" ''hl.dsp.workspace.toggle_special("todoist")'')
      (modBind "ALT + s" ''hl.dsp.workspace.toggle_special("signal")'')

      # Screenshots
      (modBind "P" ''hl.dsp.exec_cmd([[grim -t jpeg ~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).jpg]])'')
      (modBind "SHIFT + P" ''hl.dsp.exec_cmd([[grim -t jpeg -g "$(slurp)" ~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).jpg]])'')

      # Power
      (modBind "SHIFT + BackSpace" ''hl.dsp.exec_cmd("${config.home.homeDirectory}/.local/bin/power-menu.sh")'')

      # Brightness
      (rawBind "XF86MonBrightnessUp" ''hl.dsp.exec_cmd([[brightnessctl set +10% && notify-send -h int:value:$(brightnessctl -m | cut -d, -f4 | tr -d '%') " Brightness"]])'')
      (rawBind "SHIFT + XF86MonBrightnessUp" ''hl.dsp.exec_cmd([[brightnessctl set +1% && notify-send -h int:value:$(brightnessctl -m | cut -d, -f4 | tr -d '%') " Brightness"]])'')
      (rawBind "XF86MonBrightnessDown" ''hl.dsp.exec_cmd([[brightnessctl set 10%- && notify-send -h int:value:$(brightnessctl -m | cut -d, -f4 | tr -d '%') " Brightness"]])'')
      (rawBind "SHIFT + XF86MonBrightnessDown" ''hl.dsp.exec_cmd([[brightnessctl set 1%- && notify-send -h int:value:$(brightnessctl -m | cut -d, -f4 | tr -d '%') " Brightness"]])'')

      # Volume
      (rawBind "XF86AudioRaiseVolume" ''hl.dsp.exec_cmd([[pamixer -i 5 && notify-send -h int:value:$(pamixer --get-volume) "  Volume"]])'')
      (rawBind "XF86AudioLowerVolume" ''hl.dsp.exec_cmd([[pamixer -d 5 && notify-send -h int:value:$(pamixer --get-volume) "  Volume"]])'')
      (rawBind "ALT + XF86AudioRaiseVolume" ''hl.dsp.exec_cmd([[pamixer -i 1 && notify-send -h int:value:$(pamixer --get-volume) "  Volume"]])'')
      (rawBind "ALT + XF86AudioLowerVolume" ''hl.dsp.exec_cmd([[pamixer -d 1 && notify-send -h int:value:$(pamixer --get-volume) "  Volume"]])'')

      (rawBind "XF86AudioMute" ''hl.dsp.exec_cmd("${config.home.homeDirectory}/.local/bin/hyprland-mute.sh")'')
      (rawBind "SHIFT + XF86AudioRaiseVolume" ''hl.dsp.exec_cmd("playerctl next")'')
      (rawBind "SHIFT + XF86AudioLowerVolume" ''hl.dsp.exec_cmd("playerctl previous")'')
      (rawBind "SHIFT + XF86AudioMute" ''hl.dsp.exec_cmd("playerctl play-pause")'')

      (rawBind "XF86AudioPlay" ''hl.dsp.exec_cmd("playerctl play-pause")'')
      (rawBind "XF86AudioNext" ''hl.dsp.exec_cmd("playerctl next")'')
      (rawBind "XF86AudioPrev" ''hl.dsp.exec_cmd("playerctl previous")'')
      (rawBind "XF86PowerOff" ''hl.dsp.exec_cmd("nohup hyprshutdown -p 'systemctl poweroff'")'')

      # Mouse drag/resize (replaces bindm)
      {
        _args = [
          (inline ''mod .. " + mouse:272"'')
          (inline "hl.dsp.window.drag()")
          { mouse = true; }
        ];
      }
      {
        _args = [
          (inline ''mod .. " + mouse:273"'')
          (inline "hl.dsp.window.resize()")
          { mouse = true; }
        ];
      }
    ] ++ workspaceBinds;

    window_rule = [
      { match.class = "tidal-hifi"; workspace = "6 silent"; }

      # System popups
      { match.class = "^tui-centered$"; float = true; }
      { match.class = "^tui-centered$"; center = true; }
      { match.class = "^org\\.pulseaudio\\.pavucontrol$"; float = true; }
      { match.class = "^org\\.pulseaudio\\.pavucontrol$"; center = true; }

      # Special spaces
      { match.class = "Todoist"; workspace = "special:todoist silent"; }
      { match.class = "signal"; workspace = "special:signal silent"; }
    ];

    on = {
      _args = [
        "hyprland.start"
        (inline ''
          function()
            hl.exec_cmd("dunst")
            hl.exec_cmd("blueman-applet")
            hl.exec_cmd("/etc/polkit-gnome-authentication-agent-1")
            hl.exec_cmd("wl-paste -t text --watch clipman store --no-persist")
            hl.exec_cmd("wl-paste -t image --watch clipman store --no-persist")
            hl.exec_cmd("udiskie")
            hl.exec_cmd("systemctl --user start waybar")
            hl.exec_cmd("systemctl --user start sundial")
            hl.exec_cmd("systemctl --user start timers.target")
            hl.exec_cmd("1password --silent")
            hl.exec_cmd("todoist-electron")
            hl.exec_cmd("signal-desktop")
          end
        '')
      ];
    };
  };
}
