#!/usr/bin/bash

source export_vars.sh

$pacman -S noto-fonts \
           noto-fonts-cjk \
           noto-fonts-emoji \
           ttf-sarasa-gothic
       
$paru -S gruvbox-dark-gtk \
         gruvbox-dark-icons-gtk \
         gruvbox-icon-theme 
