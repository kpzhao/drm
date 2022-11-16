#!/usr/bin/bash

source export_vars.sh

$pacman -S mako \
           grim \
           slurp \
           swaybg \
           swayidle \
           swaylock \
           wl-clipboard 

$paru -S xorg-xwayland-hidpi-xprop \
         wlroots-hidpi-xprop-git \
         sway-im-git \
         clipman \
         grimshot \
         wev
