#!/bin/bash

echo -e "      ██╗ █████╗ ██████╗  ██████╗██╗  ██╗    ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗"
echo -e "      ██║██╔══██╗██╔══██╗██╔════╝██║  ██║    ██║     ██║████╗  ██║██║   ██║╚██╗██╔╝"
echo -e "      ██║███████║██████╔╝██║     ███████║    ██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝ "
echo -e " ██   ██║██╔══██║██╔══██╗██║     ██╔══██║    ██║     ██║██║╚██╗██║██║   ██║ ██╔██╗ "
echo -e " ╚█████╔╝██║  ██║██║  ██║╚██████╗██║  ██║    ███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗"
echo -e "  ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝"                                                                                                    
echo ""

##### FUNCTIONS #####
ask_yes_no() {
    while true; do
        read -p "$1 (y/n): " answer
        case $answer in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
##### END #####


##### LAPTOP #####
if ask_yes_no "Is it a laptop?"; then
    echo "Installing laptop software..."
    sudo pacman --needed --noconfirm -S brightnessctl
    echo " laptop software installed!"
fi
##### END #####


##### BASE #####
echo "Installing base..."
sudo pacman --needed --noconfirm -S base-devel curl wget unzip dosfstools vi less figlet libzip \
    tree imagemagick bluez bluez-utils mpv transmission-cli ueberzugpp fastfetch impala ripgrep
echo " base installed!"

cd ~

# TODO lf

##### WINDOW MANAGER #####
while true; do
    echo "---------------------------"
    echo "    Window Manager Menu"
    echo "---------------------------"
    echo "1) Install DWM (Xorg)"
    echo "2) Install Sway (Wayland)"
    echo "3) Quit"
    
    read -p "Enter choice [1-3]: " choice

    case $choice in
        1)
            sudo pacman --needed --noconfirm -S libx11 libxft libxinerama xorg-server xorg-xinit xorg-xsetroot \
                xclip scrot nsxiv feh peek

            echo "Installing dwm..."
            git clone https://github.com/javiorfo/dwm
            cd dwm
            sudo make clean install
            cd ..
            echo " DWM installed!"

            echo "Installing st..."
            git clone https://github.com/javiorfo/st
            cd st
            sudo make clean install
            cd ..
            echo " ST installed!"
            
            echo "Installing dmenu..."
            git clone https://github.com/javiorfo/dmenu
            cd dmenu
            sudo make clean install
            cd ..
            echo " DMENU installed!"
            
            echo "Installing config files..."
            rm .bash_profile .xinitrc
            wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.bash_profile
            wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.xinitrc
            wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/etc/X11/xorg.conf.d/00-keyboard.conf
            sudo mv 00-keyboard.conf /etc/X11/xorg.conf.d/
            echo " bash_profile set!"
            
            break
            ;;
        2)
            sudo pacman --needed --noconfirm -S sway waybar fuzzel swaybg swayidle swayimg wl-clipboard \
                wf-recorder slurp xwayland-satellite xdg-desktop-portal-gtk xdg-desktop-portal-gnome foot
            echo " Sway installed!"

            echo "Setting Sway config..."
            mkdir -p .config/niri/scripts
            wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.config/sway/scripts/idle.sh
            wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.config/sway/config
            mv idle.sh .config/sway/scripts
            mv config .config/sway
            echo " Sway configured!"

            echo "Setting waybar config..."
            mkdir -p .config/waybar
            wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.config/waybar/config.jsonc
            wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.config/waybar/style.css
            mv config.jsonc style.css .config/waybar
            echo " waybar configured!"

            echo "Setting fuzzel config..."
            mkdir -p .config/fuzzel
            wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.config/fuzzel/fuzzel.ini
            mv fuzzel.ini .config/fuzzel
            echo " fuzzel configured!"
  
            echo "Setting foot config..."
            mkdir -p .config/foot
            wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.config/foot/foot.ini
            mv foot.ini .config/foot/
            echo " foot configured!"

            echo "Installing config files..."
            rm .bash_profile
            wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.bash_profile
            echo " bash_profile set!"
            
            break
            ;;
        3)
            echo "Aborted!"
            exit 0
            ;;
        *)
            echo "Error: '$choice' is not a valid option. Please try again."
            echo ""
            ;;
    esac
done
##### END #####

echo "Installing office apps..."
sudo pacman --needed --noconfirm -S libreoffice-still ttf-iosevka-nerd zathura zathura-pdf-mupdf gimp translate-shell
echo " office apps installed!"

echo "Installing programming tools..."
sudo pacman --needed --noconfirm -S neovim lua lua-language-server jdk25-openjdk go gopls \
    delve clang netcat lsof maven jq docker docker-compose docker-buildx \
    plantuml gdb unixodbc
echo " programming tools installed!"
##### END #####


mkdir -p .config

##### EXTERNAL #####
echo "Setting nvim config..."
cd .config
git clone https://github.com/javiorfo/nvim
cd ..
echo " nvim set!"

echo "Installing yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rdf yay
echo " yay installed!"
##### END #####


##### AUR #####
echo "Installing programs from AUR..."
paru --noconfirm -S jdtls slides lombok-common java-debug librewolf-bin passcualito xautolock yts-cli undr jwtd
echo " AUR software installed!"
##### END #####


##### CONFIG FILES #####
echo "Setting bash config..."
rm .bashrc
wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.bashrc
echo " bash configured!"

echo "Setting zathura config..."
mkdir -p .config/zathura
wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.config/zathura/zathurarc
mv zathurarc .config/zathura/
echo " zathura configured!"

echo "Setting slides config..."
mkdir -p .config/slides
wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.config/slides/header.md
wget https://raw.githubusercontent.com/javiorfo/dotfiles/master/.config/slides/theme.json
mv header.md theme.json .config/slides
echo " slides configured!"

echo "Setting bluetooth config..."
sudo sed -i 's/#AutoEnable=true/AutoEnable=true/g' /etc/bluetooth/main.conf
echo " bluetooth configured!"
##### END #####


##### GROUPS AND USERS #####
echo "Setting docker group..."
sudo usermod -aG docker $USER
echo " docker configured!"
##### END #####

echo "󰣇 jarch-linux finished. Reboot your computer."
