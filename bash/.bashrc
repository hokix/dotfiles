# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias vi=vim
alias ll="ls -l"
alias tmux="tmux -2"

if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi
