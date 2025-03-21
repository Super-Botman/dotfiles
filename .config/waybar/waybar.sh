#!/bin/sh

while true; do
  cursor=$(hyprctl cursorpos | cut -d " " -f 2)
  waybar=$(pidof waybar)
  treshold=30

  if (( $cursor <= $treshold )) && [ -z "$waybar" ]; then
    waybar &
  fi

  if (( $cursor > $treshold )) && [ -n "$waybar" ];then
    killall -9 waybar
  fi
  sleep 0.3
done

