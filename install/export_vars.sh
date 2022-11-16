# mkdir -p /opt/work/bb
export paru=paru

if [[ $EUID -ne 0 ]] && command -v "sudo"  > /dev/null 2>&1; then
  export pacman="sudo pacman"
fi


function command_exists () {
  command -v "$1"  > /dev/null 2>&1;
}

if ! command_exists paru ; then
  $pacman -S git
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -sic
fi
