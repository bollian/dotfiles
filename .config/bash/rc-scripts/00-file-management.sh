#!/bin/bash

lf() {
	ls -l | grep $1
}

cl() {
	if cd $@; then
		ls
	fi
}

rv() {
	rm --verbose $@
}