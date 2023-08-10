echo "Install all tools"
sudo pacman -S alacritty awesome dunst neofetch i3 polybar rofi picom

echo "backup .config"
cp -r .config .config.bak

echo "copying wallpaper"
if [ -d /usr/share/backgrounds ]; then
  mv wallpaper-cbp.jpg /usr/share/backgrounds
else
  mkdir /usr/share/backgrounds
  mv wallpaper-cbp.jpg /usr/share/backgrounds
fi

echo "install config"
mv .config $HOME/.config

echo "restarting i3"
i3 restart

echo "Installation complete"
