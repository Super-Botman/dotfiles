echo "Install all tools"
sudo pacman -S alacritty dunst neofetch i3-wm polybar rofi picom lxappearance sddm cargo qt5-graphicaleffects qt5-quickcontrols2 qt5-svg wget
sudo pacman -S --needed git base-devel

# enable sddm
systemctl enable sddm && systemctl status sddm

echo "Install yay"
git clone https://aur.archlinux.org/yay.git 
cd yay
makepkg -si
cd ..

echo "Install skeuos"
yay -S skeuos-gtk-theme-git

echo "backup .config into .config.bak"
if ! [ -d $HOME/.config ]; then
   mv -r -p $HOME/.config $HOME/.config.bak
fi

echo "copying wallpaper"
if [ -d /usr/share/backgrounds ]; then
  mv wallpaper/wallpaper-cbp.jpg /usr/share/backgrounds
else
  sudo mkdir /usr/share/backgrounds
  sudo chown -s $USER:$USER /usr/share/backgrounds
  mv wallpaper/wallpaper-cbp.jpg /usr/share/backgrounds
fi

echo "install config"
mv .config $HOME/

echo 'select the theme "skeuos-dark" and icons "papirus"'
lxappearance

echo "install sddm theme"
sudo mkdir -p /usr/share/sddm/themes
wget https://framagit.org/MarianArlt/sddm-sugar-candy/-/archive/v.1.1/sddm-sugar-candy-v.1.1.tar.gz
sudo tar -xzvf ./sddm-sugar-candy-v.1.1.tar.gz -C /usr/share/sddm/themes

echo "setup sddm"
mv /usr/share/sddm-sugar-candy-v.1.1 /usr/share/sugar-candy
sudo cp sddm/sddm.conf /etc/
sudo cp sddm/theme.conf /usr/share/sddm/themes/sugar-candy

echo "nerd font install"
if ! [ -d $HOME/.local/share ]; then
   mkdir $HOME/.local/share
   if ! [ -d $HOME/.local/share/fonts ]; then
      mkdir $HOME/.local/share/fonts
      if ! [ -d $HOME/.local/share/fonts/ttf ]; then
	 mkdir $HOME/.local/share/fonts/ttf
      fi
   fi
fi

mkdir $HOME/.local/share/fonts/ttf/AgaveNerdFont
mkdir $HOME/.local/share/fonts/ttf/AurulentSansMonoNerdFont
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
