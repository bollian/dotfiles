#!/bin/bash

RC_SCRIPT_PATH="$HOME/.config/bash/rc-scripts"

for rc_script in $(ls $RC_SCRIPT_PATH | sort)
do
	source $RC_SCRIPT_PATH/$rc_script
done

source "$HOME/.cargo/env"
