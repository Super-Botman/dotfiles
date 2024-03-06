killall -9 polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example 2>polybar.log &
  done
else
  polybar --reload example &
fi
