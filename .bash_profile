bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export TERM=screen-256color
export EDITOR='/usr/bin/env vim'

function PS1_settings {
	local _user_and_host_="\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h"
	local _colon_=":"
	local _pwd_="\[\033[1;35m\]\w"
	local _git_branch_='\[\033[01;34m\]`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
	local _prompt_="\[\033[1;31m\]\\$\[\033[0m\] "
	export PS1="${_user_and_host_}${_colon_}${_pwd_}${_git_branch_}${_prompt_}"
}
PS1_settings

alias ll='ls -alF | less'
alias ls='ls -Fh'
alias dir='ls'
alias grep='grep --color=auto'
alias cls='clear'
alias tmux='tmux -2'
