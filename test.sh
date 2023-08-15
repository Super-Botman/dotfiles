echo "reboot ? [Y/n]"
read reboot

if [ "$reboot" == 'n' ]; then
	exit
else
	echo "reboot"
fi
