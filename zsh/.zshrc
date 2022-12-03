# ZDOTDIR=$HOME/.config/zsh

#{{{ 命令提示符、标题栏、任务栏样式、颜色
precmd() {
    # %{%F{cyan}%}
    # %n -- username
    # %{%F{green}%}
    # %M -- hostname
    # :
    # %{%F{red}%}
    # %(?..[%?]:) -- error code
    # %{%F{white}%}
    # %~ -- dir
    # $'\n' -- new line
    # %% -- %
    PROMPT="%{%F{cyan}%}%n@%{%F{green}%}%M:%{%F{red}%}%(?..[%?]:)%{%F{white}%}%~"$'\n'"%% "

    # 清空上次显示的命令
    # %30<..<内容%<< 从左截断
    # %~ 当前目录路径
    # [[ $TERM == screen* ]] && print -Pn "\ek%30<..<%~%<<\e\\"
}

# case $TERM {
#     (screen*)
#     preexec() {
#         # \ek 起始
#         # %30>..内容%<<  如果超过 30 个字符就从右截断
#         # ${1/[\\\%]*/@@@} 截断 \ 和 % 之后的内容，避免出乱码输出
#         # \e\\ 终止
#         print -Pn "\ek%30>..>${1/[\\\%]*/@@@}%<<\e\\"
#     }
#     ;;
#
#     (xterm*)
#     preexec() {
#         # \e]0;内容\a
#         print -Pn "\e]0;%~$ ${1/[\\\%]*/@@@}\a"
#     }
#     ;;
# }

#}}}

#{{{ 关于历史纪录的配置
# 历史纪录条目数量
export HISTSIZE=10000
# 注销后保存的历史纪录条目数量
export SAVEHIST=10000
# 历史纪录文件
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh_history"
# 修改 esc 超时时间为 0.01s
export KEYTIMEOUT=1
# 多个 zsh 间分享历史纪录
setopt SHARE_HISTORY
# 如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS
# 为历史纪录中的命令添加时间戳
#setopt EXTENDED_HISTORY
# 启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
# 相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS
# 在命令前添加空格，不将此命令添加到纪录文件中
setopt HIST_IGNORE_SPACE
# 加强版通配符
setopt EXTENDED_GLOB
# 在后台运行命令时不调整优先级
setopt NO_BG_NICE
# 禁用终端响铃
unsetopt BEEP
#}}}

#{{{ 按键绑定
bindkey -e
bindkey "^a"      beginning-of-line
bindkey "^e"      end-of-line
bindkey "^r"      history-incremental-search-backward
bindkey "^s"      history-incremental-search-forward
# 避免从普通模式转换成插入模式后退格键无法删除内容
bindkey "^?"      backward-delete-char

bindkey "^p"      up-line-or-search
bindkey "^n"      down-line-or-search
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^t'      quoted-insert
bindkey '^w'      forward-word
bindkey '^u'      backward-word
bindkey '^f'      kill-word
bindkey '^k'      backward-kill-word
bindkey '^g'      kill-line
bindkey '^b'      backward-kill-line

# 用 vim 编辑命令行
autoload -U       edit-command-line
zle -N            edit-command-line
bindkey '^o'      edit-command-line

# 在命令前插入 sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    # 光标移动到行末
    zle end-of-line
}

zle -N sudo-command-line
bindkey '^y' sudo-command-line

# ctrl + a 行首
# ctrl + b 删除左边所有内容
# ctrl + c 发送 SIGINT 信号
# ctrl + d 结束输入
# ctrl + e 行尾
# ctrl + f 删除右边一个词
# ctrl + g 删除右边所有内容
# ctrl + h 退格
# ctrl + i tab
# ctrl + j 回车（不能修改，不然影响 shift + 回车）
# ctrl + k 删除左边一个词
# ctrl + l 清屏
# ctrl + m 回车
# ctrl + n 下一个历史命令
# ctrl + o 用 vim 编辑命令行
# ctrl + p 上一个历史命令
# ctrl + q 清空当前行并暂存，自动填到下一行
# ctrl + r 向后搜索历史命令
# ctrl + s 向前搜索历史命令
# ctrl + t 输入转义字符（代替 ctrl + v）
# ctrl + u 向左移动一个词
# ctrl + v 输入转义字符
# ctrl + w 向右移动一个词
# ctrl + x 很多功能
# ctrl + y 命令前添加 sudo
# ctrl + z 休眠当前进程
#}}}

#{{{1 自动补全
# 扩展路径
# /v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

setopt AUTO_LIST
setopt AUTO_MENU
# 开启此选项，补全时会直接选中菜单项
# setopt MENU_COMPLETE
#

autoload -U compinit
compinit

_force_rehash() {
    ((CURRENT == 1)) && rehash
    return 1    # Because we didn't really complete anything
}
zstyle ':completion:::::' completer _force_rehash _complete _approximate

# 自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#补全点文件
_comp_options+=(globdots)

# 路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::complete:*' '\\'

# 彩色补全菜单
export ZLSCOLORS=$LS_COLORS
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# 错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# 补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

# kill 补全
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

# 使用缓存。某些命令的补全很耗时的（如 aptitude）
zstyle ':completion:*' use-cache on
_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
zstyle ':completion:*' cache-path $_cache_dir
unset _cache_dir

# 我的补全 {{{2
# 补全ping
zstyle ':completion:*:ping:*' hosts www.baidu.com www.google.com
zstyle ':completion:*:my-accounts' users-hosts user@{host1,host2}

user-complete() {
    case $BUFFER {
        "" )
            # 空行填入 "cd "
            BUFFER="cd "
            zle end-of-line
            zle expand-or-complete
            ;;

        " " )
            BUFFER="!?"
            zle end-of-line
            zle expand-or-complete
            ;;

        * )
            zle expand-or-complete
            ;;
    }
}

zle -N user-complete
bindkey "\t" user-complete
# }}}
# }}}

#{{{ 杂项
# 加载函数
autoload -U zmv

# 按照对应命令补全
compdef st=sudo
#}}}

# 插件管理 {{{
ZPLUGINDIR=$HOME/.cache/zsh/plugins

#https://github.com/mattmc3/zsh_unplugged 
function plugin-load {
  local repo plugdir initfile
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  for repo in $@; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugdir
    fi
    if [[ ! -e $initfile ]]; then
      local -a initfiles=($plugdir/*.plugin.{z,}sh(N) $plugdir/*.{z,}sh{-theme,}(N))
      (( $#initfiles )) || { echo >&2 "No init file found '$repo'." && continue }
      ln -sf "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugdir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}


# use curl download single file and source it
function load-files () {
    local file_name dir_name
    for url in $@; do
        file_name=${${url##*/}%}
        dir_name="${ZPLUGINDIR:-$HOME/.zsh/plugins}/$file_name"

        if [[ ! -d $dir_name ]]; then
            mkdir -p $dir_name
        fi
        if [[ ! -f $dir_name/$file_name ]]; then
		    echo "Downloading $url..."
            curl -sSL $url -o $dir_name/$file_name
        fi

        fpath+=$dir_name
        if (( $+functions[zsh-defer] )); then
            zsh-defer source $dir_name/$file_name
        else
            source $dir_name/$file_name
        fi
    done
}

# if you want to compile your plugins you may see performance gains
function plugin-compile() {
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  autoload -U zrecompile
  local f
  for f in $ZPLUGINDIR/**/*.zsh{,-theme}(N); do
    zrecompile -pq "$f"
  done
}

plugins=(
    # use zsh-defer magic to load the remaining plugins at hypersonic speed!
    # romkatv/zsh-defer

    # core plugins
    # zsh-users/zsh-autosuggestions
    # zsh-users/zsh-history-substring-search
    # zsh-users/zsh-completions

    # user plugins
    # rupa/z
    # hlissner/zsh-autopair
    # djui/alias-tips
    # peterhurford/up.zsh

    # load this one last
    zsh-users/zsh-syntax-highlighting
)

files=(
    # https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/fzf/fzf.plugin.zsh
)

# clone, source, and add to fpath
plugin-load $plugins
load-files $files


# }}}
source $ZDOTDIR/key-bindings.zsh
source $ZDOTDIR/completion.zsh

# 和zsh无关的配置 {{{1
# PATH
# path+=(~/.local/bin)

# aliases{{{2
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -A'

# 路径别名 {{{2
hash -d tmp="$HOME/tmpfs"
hash -d py="$HOME/scripts/python"
hash -d ff="$HOME/.mozilla/firefox/nightly"

# GIT ALIASES  {{{2
alias gc='git commit'
alias gco='git checkout'
alias ga='git add'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch -D'
alias gcp='git cherry-pick'
alias gd='git diff -w'
alias gds='git diff -w --staged'
alias grs='git restore --staged'
alias gst='git rev-parse --git-dir > /dev/null 2>&1 && git status || ls'
alias gu='git reset --soft HEAD~1'
alias gpr='git remote prune origin'
alias ff='gpr && git pull --ff-only'
alias grd='git fetch origin && git rebase origin/master'
alias gbb='git-switchbranch'
alias gbf='git branch | head -1 | xargs' # top branch
alias gl=pretty_git_log
alias gla=pretty_git_log_all
#alias gl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(green)%an %ar %C(reset) %C(bold magenta)%d%C(reset)'"
#alias gla="git log --all --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(bold magenta)%d%C(reset)'"
alias git-current-branch="git branch | grep \* | cut -d ' ' -f2"
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gec='git status | grep "both modified:" | cut -d ":" -f 2 | trim | xargs nvim -'
alias gcan='gc --amend --no-edit'

alias gp="git push -u 2>&1 | tee >(cat) | grep \"pull/new\" | awk '{print \$2}' | xargs open"
alias gpf='git push --force-with-lease'

alias gbdd='git-branch-utils -d'
alias gbuu='git-branch-utils -u'
alias gbrr='git-branch-utils -r -b develop'
alias gg='git branch | fzf | xargs git checkout'
alias gup='git branch --set-upstream-to=origin/$(git-current-branch) $(git-current-branch)'

copy-line () {
  rg --line-number "${1:-.}" | sk --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' | awk -F ':' '{print $3}' | sed 's/^\s+//' | wl-copy
}

open-at-line () {
  vim $(rg --line-number "${1:-.}" | sk --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' | awk -F ':' '{print "+"$2" "$1}')
}
# }}}
