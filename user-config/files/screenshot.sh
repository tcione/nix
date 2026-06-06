#!/usr/bin/env bash
set -euo pipefail

mode="${1:-full}"
file="$HOME/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png"

case "$mode" in
  region) grim -g "$(slurp)" "$file" ;;
  *) grim "$file" ;;
esac

wl-copy --type image/png < "$file"

action=$(notify-send \
  --app-name=screenshot \
  --icon="$file" \
  --action=default="Edit in Satty" \
  --expire-time=8000 \
  "Screenshot captured" \
  "Saved to ${file/#$HOME/\~} · copied to clipboard")

if [ "$action" = "default" ]; then
  exec satty --filename "$file" --output-filename "$file" --early-exit
fi
