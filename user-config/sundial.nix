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

          BERLIN_LAT="52.56"
          BERLIN_LON="13.39"
          API_URL="https://api.sunrisesunset.io/json?lat=$BERLIN_LAT&lng=$BERLIN_LON&time_format=military"
          TZ_DATA=$(curl "$API_URL")
          TIME=$(date +%H%M)
          SUNRISE=$(echo "$TZ_DATA" | jq '.results | .sunrise')
          SUNSET=$(echo "$TZ_DATA" | jq '.results | .sunset')
          STATE_PATH="$HOME/.sundial-temperature"
          PID=$(pgrep -io "hyprsunset" || echo "nopid")

          if [[ -f "$STATE_PATH" ]]; then
            LAST_TEMPERATURE=$(cat "$STATE_PATH")
          else
            LAST_TEMPERATURE="undefined"
          fi

          NEW_TEMPERATURE="6000"
          NEW_GAMMA="100"
          if [[ "$TIME" > "$SUNSET" ]] || [[ "$TIME" < "$SUNRISE" ]]; then
            NEW_TEMPERATURE="2800"
            NEW_GAMMA="80"
          fi

          if [[ "$PID" == "nopid" ]]; then
            systemctl start --user hyprsunset
          fi

          if [[ "$PID" == "nopid" ]] || [[ "$LAST_TEMPERATURE" != "$NEW_TEMPERATURE" ]]; then
            echo "$NEW_TEMPERATURE" > "$STATE_PATH"
            hyprctl hyprsunset temperature "$NEW_TEMPERATURE"
            hyprctl hyprsunset gamma "$NEW_GAMMA"
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
        OnBootSec = "1m";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
