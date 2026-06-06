{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        height = 30;
        spacing = 4;
        modules-left = [
          "custom/system"
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "idle_inhibitor"
          "pulseaudio"
          "backlight"
          "group/hardware"
          "network"
        ];
        "group/hardware" = {
          orientation = "horizontal";
          drawer = {
              transition-duration = 500;
              children-class = "not-battery";
              transition-left-to-right = true;
          };
          modules = [
            "battery"
            "cpu"
            "memory"
            "temperature"
          ];
        };
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "[{name}]";
          format-icons = {
            default = "[ø]";
          };
        };
        backlight = {
          device = "intel_backlight";
          format = "{percent}% {icon}";
          format-icons = ["" ""];
        };
        tray = {
          spacing = 10;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            deactivated = "";
            activated = "";
            tooltip = false;
          };
        };
        clock = {
          tooltip-format = "<tt>{calendar}</tt>";
          format = "{:%A, %d/%m, %H:%M}";
          format-alt = "{:%Y-%m-%d %H:%M:%S}";
          calendar = {
            mode = "year";
              mode-mon-col = 4;
              weeks-pos = "left";
              on-scroll = 1;
              format = {
                months = "<span color='#cdd6f4'><b>{}</b></span>";
                days = "<span color='#cdd6f4'><b>{}</b></span>";
                weeks = "<span color='#89dceb'><b>#{}</b></span>";
                weekdays = "<span color='#fab387'><b>{}</b></span>";
                today = "<span color='#f2cdcd'><b><u>{}</u></b></span>";
              };
          };
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
          on-click = "ghostty --class=tui-centered -e btm";
        };
        memory = {
          format = "{}% ";
          on-click = "ghostty --class=tui-centered -e btm";
        };
        temperature = {
          thermal-zone = 1;
          format = "{temperatureC}°C ";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };
        network = {
          format-wifi = " ";
          format-ethernet = "";
          tooltip-format = "{essid} ({signalStrength}%) - {ipaddr}/{cidr} @ {ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click-right = "ghostty --class=tui-centered -e impala";
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon} ";
          format-bluetooth-muted = " {icon} ";
          format-muted = "󰝟";
          format-source = "| {volume}% ";
          format-source-muted = "| ";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["󰖁" "" "" ""];
          };
          on-click = "pwvucontrol";
        };
        "custom/system" = {
          format = "";
          on-click = "ghostty --class=tui-centered -e fastfetch";
        };
      };
    };
    style = ./files/waybar-style.css;
  };
}
