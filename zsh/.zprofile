# profile file. Runs on login. Environmental variables are set here.

# set XDG base directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# set envvar for XDG base dir support
export ZDOTDIR="$HOME/.config/zsh"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=fcitx 
export XMODIFIERS="@im=fcitx"

# qt theme
export QT_QPA_PLATFORMTHEME=qt5ct

# export GDK_SCALE=2

path+=(~/.local/bin)


