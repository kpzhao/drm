if status is-interactive
    # Commands to run in interactive sessions can go here


set -x my_proxy socks5h://127.0.0.1:10800
abbr -a p-on 'export all_proxy='{$my_proxy}' http_proxy='{$my_proxy}' https_proxy='{$my_proxy}''
abbr -a p-off 'set -e  all_proxy http_proxy https_proxy'
abbr -a config '/usr/bin/git --git-dir=$HOME/.drm/ --work-tree=$HOME'
abbr -a caffine 'systemd-inhibit --what=idle sleep inf'
end

# fzf
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
