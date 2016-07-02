#!/bin/bash

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
