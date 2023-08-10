echo "Install all tools"
sudo pacman -S alacritty awesome dunst neofetch i3 polybar rofi picom

echo "backup .config"
cp -r .config .config.bak

echo "copying wallpaper"
if [ -d $HOME/Pictures ]; then
  mkdir $HOME/Pictures/wallpaper
else
  mkdir $HOME/Pictures
  mkdir $HOME/Pictures/wallpaper
fi

mv wallpaper-cbp.jpg $HOME/Pictures/wallpaper/

echo "install config"
mv .config $HOME/.config

echo "restarting i3"
i3 restart

echo "Installation complete"
