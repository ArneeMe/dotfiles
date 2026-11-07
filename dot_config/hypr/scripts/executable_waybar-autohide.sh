#!/usr/bin/env bash
HIDE_CLASS="eu4"
hidden=0

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
| while IFS= read -r line; do
    case "$line" in
      activewindow\>\>*)
        rest="${line#activewindow>>}"
        class="${rest%%,*}"
        echo "got class=[$class] hidden=$hidden"
        if [[ "$class" == "$HIDE_CLASS" && $hidden -eq 0 ]]; then
          pkill -SIGUSR1 waybar && echo "  -> hiding" && hidden=1
        elif [[ "$class" != "$HIDE_CLASS" && $hidden -eq 1 ]]; then
          pkill -SIGUSR1 waybar && echo "  -> showing" && hidden=0
        fi
        ;;
    esac
  done
