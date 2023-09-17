#!/bin/bash

username=$(logname)
#export flouser #not needed yet

# draft distro detection:
if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"') == "Linux Mint" ]; then echo "Linux Mint"; fi
if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"') == "Ubuntu" ]; then echo "Ubuntu"; fi
if [ -e /usr/share/plymouth/themes/ubuntucinnamon-spinner ]; then echo "Ubuntu Cinnamon"; fi #this have to be placed exactly after Ubuntu, to patch the current value, bc UCR is also calling itself Ubuntu in /etc/os-release
if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"') == "Floflis" ]; then echo "Floflis"; fi

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="How you prefer your mouse cursor color?"

OPTIONS=(1 "⚫Black (like in \"MecOS\"🍎)"
         2 "⚪White (like in \"WindOS\"🪟)")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            gsettings set org.cinnamon.desktop.interface cursor-theme 'Floflis' #from https://askubuntu.com/a/72093
            ;;
        2)
            gsettings set org.cinnamon.desktop.interface cursor-theme 'DMZ-White' #from https://askubuntu.com/a/72093
            ;;
esac
#from https://askubuntu.com/a/666179
#in UI, will have different background as example

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="How you prefer your system theme?"

OPTIONS=(1 "⚫Dark (let's save my eyes while computing in the dark)"
         2 "🟤Normal (i have strong eyes)"
         3 "⚪Light (i have stronger eyes, still; let's not abuse)")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-floflis-dark' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-floflis-dark' && gsettings set org.cinnamon.theme name 'Yaru-floflis-dark' #from https://askubuntu.com/a/72093
            ;;
        2)
            gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-floflis' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-floflis' && gsettings set org.cinnamon.theme name 'Yaru-floflis' #from https://askubuntu.com/a/72093
            ;;
        3)
            gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-floflis-light' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-floflis-light' && gsettings set org.cinnamon.theme name 'Yaru-floflis-light' #from https://askubuntu.com/a/72093
            ;;
esac
#from https://askubuntu.com/a/666179
#in UI, will have different background as example

#if [ -e /1 ]; then #only run what's inside if Floflis-based OS is detected
#fi

if [ -e /1 ]; then #only run what's inside if Floflis-based OS is detected
echo "Do you want to install the MS Edge browser? [Y/n]"
   read setedge
   case $setedge in
      [nN])
         echo "Ok, not going to install MS Edge for now; anyway it should be available in Floflis' stores."
         ;;
      [yY])
         echo "Important:" && echo ""
         cat /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/DEB/TERMS && echo ""
         echo "Privacy statement: https://go.microsoft.com/fwlink/?LinkId=521839" && echo ""
         echo "Installing Microsoft Edge will add the Microsoft repository so your system will automatically keep Microsoft Edge up to date." && echo ""
         echo "Scroll up to read. PLEASE READ/WRITE CAREFULLY!"
         echo "Do you agree with the terms? [Y/n]"
            read licenseagreement
            case $licenseagreement in
               [nN])
                  exit ;;
               [yY])
                  echo "Installing MS Edge..."
                  sudo dpkg -i /usr/lib/floflis/layers/soil/to-merge/include-firstlogon/DEB/microsoft-edge-stable_110.0.1587.57-1_amd64.deb
            esac
esac
fi

if [ -e /1 ]; then #only run what's inside if Floflis-based OS is detected
echo "Do you want to install the \"WindOS\"🪟 Calculator? [Y/n]"
echo "Please note Floflis do already include a basic calculator by default."
   read setunocalc
   case $setunocalc in
      [nN])
         echo "Ok, not going to install WinCalculator for now; anyway it should be available in Floflis' stores."
         ;;
      [yY])
         sudo snap install uno-calculator
esac
#if user is an IT technician installing for a customer, don't ask and install MS Edge and Calculator right away)
#floflis fixer should support reinstalling default calculator
fi
