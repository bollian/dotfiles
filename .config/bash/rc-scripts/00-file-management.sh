#!/bin/bash

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

ll() {
	ls -laF $@
}

lf() {
	ll | grep $1
}

cl() {
	cd $@ && ls
}

rv() {
	rm --verbose $@
}
