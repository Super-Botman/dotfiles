#!/bin/sh
show_wallpaper()
{
  i=0
  files=($(ls -d $HOME/.config/backgrounds/$1/*.mp4))

  while true; do
    $HOME/.config/backgrounds/wallpaper.sh -a ${files[i]}
    sleep $((60*45 + $RANDOM % 60*60))
    killall -9 mpv
    if [ ${#files[@]} == $((i+1)) ]; then
      i=0
    fi
    i=$((i+1))
  done
}

get_sunset()
{
 currenttime=$(date +%R)
 request=$(curl -s 'https://api.sunrise-sunset.org/json?lat=44.538631&lng=6.495930&tzid=Europe/Paris')
 sunrise=$(date -d "$(echo $request | jq -r '.results.sunrise')" +%R)
 sunset=$(date -d "$(echo $request | jq -r '.results.sunset')" +%R)
}

main()
{
  time=''
  sunrise=''
  sunset=''

  killall -9 mpv
  get_sunset

  while :; do
   new_time=''
   if [[ "$currenttime" < "$sunrise" ]] || [[ "$currenttime" > "$sunset" ]]; then
     new_time='night'
   else
     new_time='day'
   fi

   if [[ "$time" != "$new_time" ]]; then
     show_wallpaper $new_time
     get_sunset
   fi
   time=$new_time
  done &
}

main
