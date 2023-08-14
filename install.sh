USER=$(whoami)

if $USER != 'root'; then
  echo "install.sh must be run as root"
fi

echo "Install all tools"
pacman -S alacritty awesome dunst neofetch i3 polybar rofi picom skeuos-gtk-theme-git lxaperance sddm

echo "backup .config"
cp -r -p $HOME/.config $HOME/.config.bak

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

echo 'select the theme "skeuos-dark" and icons "papirus"'
lxappearance

echo "setup sddm"
mv sddm/sddm.conf

echo "install sddm theme"
git clone https://framagit.org/MarianArlt/sddm-sugar-candy.git /usr/share/sddm/themes/
mv sddm/theme.conf /usr/share/sddm/themes/sugar-candy

echo "nerd font install"
tar -xvzf fonts/AgaveNerdFont.tar.gz -C $HOME/.local/share/fonts/ttf/AgaveNerdFont
tar -xvzf fonts/AurulentSansMonoNerdFont.tar.gz -C $HOME/.local/share/fonts/ttf/AurulentSansMonoNerdFont

echo "Installation complete"
