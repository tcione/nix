{ config, pkgs, ... }:

{
  systemd.user.services = {
    sundial = {
      Unit.Description = "sets screen temperature based on time of the day";
      Service = {
        Type = "oneshot";
        ExecStart = toString (
        pkgs.writeShellScript "sundial" ''
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
    sundial = {
      Unit.Description = "timer for sundial service";
      Timer = {
        Unit = "sundial.service";
        OnCalendar = "*:0/30";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
