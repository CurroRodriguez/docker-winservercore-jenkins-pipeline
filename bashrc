# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

export PS1='\[\033[01;33m\]\u:\[\033[01;36m\]\W \[\033[01;35m\]\$ \[\033[00m\]'
alias ls='ls --color=auto'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias ..='cd ..'
alias ...='cd ../..'
alias psl=powershell
set -o vi
trap '' SIGINT
