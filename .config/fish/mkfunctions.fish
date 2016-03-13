#!/usr/bin/fish
# the purpose of this script is to generate the list of functions that
# have been implemented in bash but I want accessible in fish
# 
# all it does is create auto-loading function scripts that call the bash function

set FUNCS cl croot fetch glog glogl lf ll pull push repotype root rstat rv

mkdir $HOME/.config/fish/functions -p

for func in $FUNCS
	set O_FILE $HOME/.config/fish/functions/"$func".fish
	
	printf "function $func\n" > $O_FILE
	printf "\tbash -i -c \"$func \$argv\"\n" >> $O_FILE
	printf "end\n" >> $O_FILE
end
