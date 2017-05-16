bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export export TERM=screen-256color
PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '
alias ll='ls -alGF | less'
alias ls='ls -GFh'
alias dir='ls'
alias grep='grep --color=auto'
alias cls='clear'
alias tmux='tmux -2'
