#!/bin/bash

alias ls='ls --color=auto'
alias ll='ls -laF'
alias lf='ll | grep'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias rv='rm --verbose'

cl() {
	cd $@ && ls
}
