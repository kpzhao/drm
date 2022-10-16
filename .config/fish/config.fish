if status is-interactive
    # Commands to run in interactive sessions can go here


set -x my_proxy socks5h://127.0.0.1:10800
abbr -a p-on 'export all_proxy='{$my_proxy}' http_proxy='{$my_proxy}' https_proxy='{$my_proxy}''
abbr -a p-off 'set -e  all_proxy http_proxy https_proxy'
abbr -a config '/usr/bin/git --git-dir=$HOME/.drm/ --work-tree=$HOME'

end
