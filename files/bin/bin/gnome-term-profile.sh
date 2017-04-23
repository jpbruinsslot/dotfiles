#!/bin/bash
profile="b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
palette="#1B1B1D1D1E1E:#F9F926267272:#8282B4B41414:#FDFD97971F1F:#5656C2C2D6D6:#8C8C5454FEFE:#464654545757:#CCCCCCCCC6C6:#505053535454:#FFFF59599595:#B6B6E3E35454:#FEFEEDED6C6C:#8C8CEDEDFFFF:#9E9E6F6FFEFE:#89899C9CA1A1:#F8F8F8F8F2F2"
bd_color="#F8F8F8F8F2F2"
fg_color="#F8F8F8F8F2F2"
bg_color="#262626262626"

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ background-color $bg_color
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ foreground-color $fg_color
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ bold-color $bd_color
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ palette "['#1B1B1D1D1E1E','#F9F926267272','#8282B4B41414','#FDFD97971F1F','#5656C2C2D6D6','#8C8C5454FEFE','#464654545757','#CCCCCCCCC6C6','#505053535454','#FFFF59599595','#B6B6E3E35454','#FEFEEDED6C6C','#8C8CEDEDFFFF','#9E9E6F6FFEFE','#89899C9CA1A1','#F8F8F8F8F2F2']"

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ bold-color-same-as-fg false

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ font "Ubuntu Mono 10"

