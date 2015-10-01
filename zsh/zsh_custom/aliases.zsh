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

# almost pointless sudo alias
# ensures the command being sudoed is
# scanned for any aliases.
alias sudo='sudo '

alias mmv='noglob zmv -W'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias vless="vim --cmd 'let no_plugin_maps = 1' -c 'runtime! macros/less.vim'"

alias ccat='colorize'

alias door='clear;x=$(($COLUMNS/2));y=$(($LINES/2));c=0;n=1;a=90;while :;do bgc=$(($c%232 + 16));case "$a" in 0)xd=0;yd=-1;n=$(($n+1));; 90)xd=1;yd=0;; 180)xd=0;yd=1;n=$(($n+1));; 270)xd=-1;yd=0 ;; *) break ;; esac; for ((i=0;i < $n;i++));do if [[ $x -ge $COLUMNS || $x -le 0 || $y -ge $LINES || $y -le 0 ]]; then x=$(($COLUMNS/2));y=$(($LINES/2));n=1;a=0; continue ; fi ; printf "\033[%s;%sH\033[48;5;%sm \033[0m" $y $x $bgc ; x=$(( $x + $xd )); y=$(( $y + $yd )); done ; c=$(( $c + 1 )); a=$(( $(( $a + 90 )) % 360 )) ; sleep 0.001; done'

alias worm='a=1;x=1;y=1;xd=1;yd=1;while true;do if [[ $x == $LINES || $x == 0 ]]; then xd=$(( $xd *-1 )) ; fi ; if [[ $y == $COLUMNS || $y == 0 ]]; then yd=$(( $yd * -1 )) ; fi ; x=$(( $x + $xd )); y=$(( $y + $yd )); printf "\33[%s;%sH\33[48;5;%sm \33[0m" $x $y $(($a%199+16)) ;a=$(( $a + 1 )) ; sleep 0.001 ;done'

alias snow='clear;while :;do echo $LINES $COLUMNS $(($RANDOM%$COLUMNS)) $(printf "\u2743\n");sleep 0.1;done|gawk '\''{a[$3]=0;for(x in a) {o=a[x];a[x]=a[x]+1;printf "\033[%s;%sH ",o,x;printf "\033[%s;%sH%s \033[0;0H",a[x],x,$4;}}'\'''

alias gma='git merge --abort'
alias ggpush='git push origin --set-upstream $(current_branch) && openJenkinsJob $(current_branch) &>/dev/null &'
alias gmnff='git merge --no-ff'
alias gs='echo "Did you really mean to invoke ghostscript?"; read; if [[ $REPLY == "y" ]]; then gs; else echo "I didn''t think so.";fi'
alias gsb='git show-branch'
alias grhu='git reset --hard @{u}'


####################
#  GLOBAL ALIASES  #
####################
alias -g G=' | grep'
alias -g C=' | column -ts'
alias -g V=' | vless -'
alias -g ...='../..'
alias -g ....='../../..'
alias -g L='| less'
alias -g DN='/dev/null'
alias -g A=' | awk'
