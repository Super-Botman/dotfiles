echo "Install all tools"
sudo pacman -S alacritty awesome dunst neofetch i3-wm polybar rofi picom git lxappearance sddm cargo
sudo pacman -S --needed git base-devel

echo "Install yay"
git clone https://aur.archlinux.org/yay.git 
yay/makepkg -si

echo "Install skeuos"
yay -S skeuos-gtk-theme-git

echo "backup .config into .config.bak"
if ! [ -d $HOME/.config ]; then
   cp -r -p $HOME/.config $HOME/.config.bak
fi

echo "copying wallpaper"
if [ -d /usr/share/backgrounds ]; then
  mv wallpaper/wallpaper-cbp.jpg /usr/share/backgrounds
else
  mkdir /usr/share/backgrounds
  mv wallpaper/wallpaper-cbp.jpg /usr/share/backgrounds
fi

echo "install config"
mv .config $HOME/

echo 'select the theme "skeuos-dark" and icons "papirus"'
lxappearance

echo "install sddm theme"
git clone https://framagit.org/MarianArlt/sddm-sugar-candy.git /usr/share/sddm/themes/

echo "setup sddm"
cp sddm/sddm.conf /etc
cp sddm/theme.conf /usr/share/sddm/themes/sugar-candy

echo "nerd font install"
tar -xvzf fonts/AgaveNerdFont.tar.gz -C $HOME/.local/share/fonts/ttf/AgaveNerdFont
tar -xvzf fonts/AurulentSansMonoNerdFont.tar.gz -C $HOME/.local/share/fonts/ttf/AurulentSansMonoNerdFont
fc-cache

echo "Installation complete"

echo "reboot ? [N/y]"
read reboot

if  [ "$reboot" == 'y' ] || [ "$reboot" == 'Y' ]; then
	reboot
else
	exit
fi
