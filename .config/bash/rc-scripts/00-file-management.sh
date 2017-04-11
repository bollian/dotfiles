#!/bin/bash

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

lf() {
	ls -la | grep $1
}

cl() {
	if cd $@; then
		ls
	fi
}

rv() {
	rm --verbose $@
}
