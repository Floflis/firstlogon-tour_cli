#!/bin/bash

username=$(logname)
#export flouser #not needed yet

# draft distro detection:
if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"') == "Linux Mint" ]; then distrotype="Linux Mint"; fi
if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"') == "Ubuntu" ]; then distrotype="Ubuntu"; fi
if [ -e /usr/share/plymouth/themes/ubuntucinnamon-spinner ]; then distrotype="Ubuntu Cinnamon"; fi #this have to be placed exactly after Ubuntu, to patch the current value, bc UCR is also calling itself Ubuntu in /etc/os-release
if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"') == "Floflis" ]; then distrotype="Floflis"; fi

changecursor_black () {
if [ $distrotype == "Linux Mint" ]; then gsettings set org.cinnamon.desktop.interface cursor-theme 'Bibata-Modern-Classic'; fi
if [ $distrotype == "Ubuntu" ]; then gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'; fi
if [ $distrotype == "Ubuntu Cinnamon" ]; then gsettings set org.cinnamon.desktop.interface cursor-theme 'Yaru'; fi
if [ $distrotype == "Floflis" ]; then gsettings set org.cinnamon.desktop.interface cursor-theme 'Floflis'; fi
}

changecursor_white () {
if [ $distrotype == "Linux Mint" ]; then gsettings set org.cinnamon.desktop.interface cursor-theme 'DMZ-White'; fi
if [ $distrotype == "Ubuntu" ]; then gsettings set org.gnome.desktop.interface cursor-theme 'DMZ-White'; fi
if [ $distrotype == "Ubuntu Cinnamon" ]; then gsettings set org.cinnamon.desktop.interface cursor-theme 'DMZ-White'; fi
if [ $distrotype == "Floflis" ]; then gsettings set org.cinnamon.desktop.interface cursor-theme 'DMZ-White'; fi
}

changethemestyle_dark () {
if [ $distrotype == "Linux Mint" ]; then gsettings set org.cinnamon.desktop.wm.preferences theme 'Mint-Y-Dark-Aqua' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Dark-Aqua' && gsettings set org.cinnamon.theme name 'Mint-Y-Dark-Aqua'; fi
if [ $distrotype == "Ubuntu" ]; then gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark' && gsettings set org.gnome.desktop.wm.preferences theme 'Yaru-dark'; fi
if [ $distrotype == "Ubuntu Cinnamon" ]; then gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-cinnamon-dark' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-cinnamon-dark' && gsettings set org.cinnamon.theme name 'Yaru-cinnamon-dark'; fi
if [ $distrotype == "Floflis" ]; then gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-floflis-dark' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-floflis-dark' && gsettings set org.cinnamon.theme name 'Yaru-floflis-dark'; fi
}

changethemestyle_default () {
if [ $distrotype == "Linux Mint" ]; then gsettings set org.cinnamon.desktop.wm.preferences theme 'Mint-Y-Aqua' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Aqua' && gsettings set org.cinnamon.theme name 'Mint-Y-Aqua'; fi
if [ $distrotype == "Ubuntu" ]; then gsettings set org.gnome.desktop.interface gtk-theme 'Yaru' && gsettings set org.gnome.desktop.wm.preferences theme 'Yaru'; fi
if [ $distrotype == "Ubuntu Cinnamon" ]; then gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-cinnamon' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-cinnamon' && gsettings set org.cinnamon.theme name 'Yaru-cinnamon'; fi
if [ $distrotype == "Floflis" ]; then gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-floflis' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-floflis' && gsettings set org.cinnamon.theme name 'Yaru-floflis'; fi
}

changethemestyle_light () {
#if [ $distrotype == "Linux Mint" ]; then ; fi
#if [ $distrotype == "Ubuntu" ]; then ; fi
#if [ $distrotype == "Ubuntu Cinnamon" ]; then ; fi
if [ $distrotype == "Floflis" ]; then gsettings set org.cinnamon.desktop.wm.preferences theme 'Yaru-floflis-light' && gsettings set org.cinnamon.desktop.interface gtk-theme 'Yaru-floflis-light' && gsettings set org.cinnamon.theme name 'Yaru-floflis-light'; fi
}

# Work as a backend for our Flutter GUI ---->
if [ "$1" = "changecursor_black" ]; then changecursor_black; fi
if [ "$1" = "changecursor_white" ]; then changecursor_white; fi
if [ "$1" = "changethemestyle_dark" ]; then changethemestyle_dark; fi
if [ "$1" = "changethemestyle_default" ]; then changethemestyle_default; fi
if [ "$1" = "changethemestyle_light" ]; then changethemestyle_light; fi
# <---- Work as a backend for our Flutter GUI

if [ "$1" = "" ]; then #mean it is running in interactive mode, without GUI

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
            changecursor_black
            ;;
        2)
            changecursor_white
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
            changethemestyle_dark
            ;;
        2)
            changethemestyle_default
            ;;
        3)
            changethemestyle_light
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

fi
