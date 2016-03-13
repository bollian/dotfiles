#!/bin/bash

repotype() {
	if git rev-parse --show-toplevel > /dev/null 2> /dev/null; then
		echo "git"
	elif hg root > /dev/null 2> /dev/null; then
		echo "hg"
	else
		echo "No repository was found." >&2
		return 1
	fi
}

root() {
	if RTYPE=$(repotype); then
		if [[ $RTYPE -eq "git" ]]; then
			git rev-parse --show-toplevel
		elif [[ $RTYPE -eq "hg" ]]; then
			hg root
		else
			echo "'root' does not support $RTYPE" >&2
		fi
	else
		return 1
	fi
}

croot() {
	if RROOT=$(root); then
		cd $RROOT
	else
		return 1
	fi
}

rstat() {
	if RTYPE=$(repotype); then
		$(echo $RTYPE) status $@
	else
		return 1
	fi
}

push() {
	if RTYPE=$(repotype); then
		$(echo $RTYPE) push $@
	else
		return 1
	fi
}

fetch() {
	if RTYPE=$(repotype); then
		if [[ $RTYPE -eq "git" ]]; then
			git fetch $@
		elif [[ $RTYPE -eq "hg" ]]; then
			hg pull $@
		else
			echo "'fetch' does not support $RTYPE" >&2
		fi
	else
		return 1
	fi
}

pull() {
	if RTYPE=$(repotype); then
		if [[ $RTYPE -eq "git" ]]; then
			git pull $@
		elif [[ $RTYPE -eq "hg" ]]; then
			hg pull $@
			hg update
		else
			echo "'pull' does not support $RTYPE" >&2
		fi
	else
		return 1
	fi
}

glog() {
	if RTYPE=$(repotype); then
		$(echo $RTYPE) glog
	else
		return 1
	fi
}

glogl() {
	if RTYPE=$(repotype); then
		$(echo $RTYPE) glogl
	else
		return 1
	fi
}