#!/bin/bash
#
# Quickly Setting up Awesome with Gnome
# script follows http://awesome.naquadah.org/wiki/Quickly_Setting_up_Awesome_with_Gnome
# Gnome 3.9 / Ubuntu 13.10 

temp_file="./.temp_gnome_setup"
backup_file="./.gnome_setup_backup"

# 1. generating /usr/share/gnome-session/sessions/awesome.session
file="/usr/share/gnome-session/sessions/awesome.session"
if [ -e $file ]
then
    echo "$file exist, skip ..."
else
    echo "generating $file ..."
    echo "
    [GNOME Session]
    Name=Awesome session
    RequiredComponents=awesome;gnome-settings-daemon;
    DesktopName=Awesome
    " > $temp_file
    sudo mv $temp_file $file
fi

# 2. generating /usr/share/applications/awesome.desktop
file="/usr/share/applications/awesome.desktop"
if [ -e $file ]
then
    echo "$file exist, skip..."
else
    echo "generating $file ..."
    echo "
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=Awesome
    Comment=The awesome launcher!
    TryExec=awesome
    Exec=awesome
    " >  $temp_file
    sudo mv $temp_file $file
fi

# 3. generating /usr/share/xsessions/awesome-gnome.desktop
file="/usr/share/xsessions/awesome-gnome.desktop"
if [ -e $file ]
then
    echo "$file exist, skip..."
else
    echo "generating $file ..."
    echo "
    [Desktop Entry]
    Name=Awesome GNOME
    Comment=Dynamic window manager
    Exec=gnome-session --session=awesome
    TryExec=awesome
    Type=Application
    X-LightDM-DesktopName=Awesome GNOME
    X-Ubuntu-Gettext-Domain=gnome-session-3.0
    " >  $temp_file
    sudo mv $temp_file $file
fi

#function to add Awesome to OnlyShowIn
add_awesome_OnlyShowIn() {
    file=$1
    if [ -e $file ]
    then
        echo "add Awesome to OnlyShowIn: $file"

        #backup
        cat $file > $temp_file
        mv --backup=numbered $temp_file $backup_file

        awk '!/OnlyShowIn/{print}; /OnlyShowIn/ {if (!index($1,"Awesome")) { $1=$1 "Awesome;"; print $0} else print $0 };' $file > $temp_file
        sudo mv $temp_file $file
    else
        echo "$file don't exist, skip..."
    fi
}
# 4. modify  /etc/xdg/autostart/gnome-settings-daemon.desktop to add Awesome to the OnlyShowIn key
add_awesome_OnlyShowIn  /etc/xdg/autostart/gnome-settings-daemon.desktop

# 5. and others
add_awesome_OnlyShowIn  /etc/xdg/autostart/gnome-keyring-gpg.desktop
add_awesome_OnlyShowIn  /etc/xdg/autostart/gnome-keyring-pkcs11.desktop
add_awesome_OnlyShowIn  /etc/xdg/autostart/gnome-keyring-secrets.desktop
add_awesome_OnlyShowIn  /etc/xdg/autostart/gnome-keyring-ssh.desktop
add_awesome_OnlyShowIn  /etc/xdg/autostart/gnome-screensaver.desktop
add_awesome_OnlyShowIn  /etc/xdg/autostart/gnome-settings-daemon.desktop
add_awesome_OnlyShowIn  /etc/xdg/autostart/gsettings-data-convert.desktop
add_awesome_OnlyShowIn  /etc/xdg/autostart/indicator-messages.desktop
add_awesome_OnlyShowIn  /etc/xdg/autostart/polkit-gnome-authentication-agent-1.desktop
add_awesome_OnlyShowIn  /etc/xdg/autostart/vino-server.desktop
add_awesome_OnlyShowIn  /etc/xdg/autostart/indicator-session.desktop

# gnome-control-center is missing some menues, check all files /usr/share/applications/gnome*panel*. Adding Awesome to the OnlyShowIn Key will make them visible and accessible again. 
add_awesome_OnlyShowIn /usr/share/applications/gnome-bluetooth-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-color-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-datetime-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-deja-dup-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-display-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-info-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-keyboard-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-mouse-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-network-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-online-accounts-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-power-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-printers-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-region-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-screen-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-sound-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-universal-access-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-user-accounts-panel.desktop
add_awesome_OnlyShowIn /usr/share/applications/gnome-wacom-panel.desktop



