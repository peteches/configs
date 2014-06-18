# vim: ft=zsh

#aliases
alias sort="sort -S$(($(sed '/MemT/!d;s/[^0-9]*//g' /proc/meminfo)/1024-200))"
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ks='ls' # yeah another typo fix
if [[ -x $( type -p vimx | awk '{print $NF}' ) ]]; then
    alias vim='vimx'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias vless="vim --cmd 'let no_plugin_maps = 1' -c 'runtime! macros/less.vim'"

alias cat='colorize'

# sudo aliases
alias virsh='sudo virsh'
alias iptables='sudo iptables'
alias docker='sudo docker'
alias pacman='sudo pacman'
alias ggpush='git push origin $(current_branch) && [[ $(current_branch) =~ "STAGE|LIVE|TEST_[1-8]" ]] && xdg-open http://gueaplatci01.skybet.net:8080/job/$(current_branch)'
alias yi='sudo yum install --assumeyes'


####################
#  GLOBAL ALIASES  #
####################
alias -g G=' | grep'
alias -g C=' | column -ts'
alias -g V=' | vless;'
