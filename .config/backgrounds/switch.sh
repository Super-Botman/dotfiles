#!/bin/sh
show_wallpaper()
{
  i=0
  files=($(ls -d $HOME/.config/backgrounds/$1/*.mp4))

  while true; do
    killall -9 xwinwrap
    xwinwrap -ov -ni -g 1920x1080+0+0 -- mpv --fs --loop-file --no-audio --no-osc --no-osd-bar -wid WID --no-input-default-bindings ${files[i]} &
    sleep $((60*20 + $RANDOM % 60*30))
    i=$((i+1))
    if [ ${#files[@]} == $i ]; then
      i=0
    fi
  done
}

get_sunset()
{
 request=$(curl -s 'https://api.sunrise-sunset.org/json?lat=44.538631&lng=6.495930&tzid=Europe/Paris')
 sunrise=$(date -d "$(echo $request | jq -r '.results.sunrise')" +%R)
 sunset=$(date -d "$(echo $request | jq -r '.results.sunset')" +%R)
}

main()
{
  time=''
  sunrise=''
  sunset=''

  killall -9 xwinwrap
  get_sunset

  while :; do
   currenttime=$(date +%R)
   new_time=''
   if [[ "$currenttime" < "$sunrise" ]] || [[ "$currenttime" > "$sunset" ]]; then
     new_time='night'
   else
     new_time='day'
   fi

   if [[ "$time" != "$new_time" ]]; then
     kill %1
     show_wallpaper $new_time &
     get_sunset
   fi
   time=$new_time

   sleep 2
  done
}

main
