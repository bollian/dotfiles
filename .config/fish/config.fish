#!/usr/bin/fish

# version control stuff
function repotype
	if git rev-parse --show-toplevel > /dev/null 2> /dev/null
		echo "git"
	else if hg root > /dev/null 2> /dev/null
		echo "hg"
	else
		echo "No repository was found."
	end
end

function root
	set TYPE (repotype)
	switch (echo $TYPE)
	case "git" # weird characters are inserted into the echo output
		git rev-parse --show-toplevel
	case "hg"
		hg root
	case "*"
		echo $TYPE
	end
end

function croot
	set REPO_DIR (root)
	if [ $REPO_DIR = "No repository was found." ]
		echo $REPO_DIR
	else
		cd (root)
	end
end

function push
	set TYPE (repotype)
	if [ $TYPE = "git" ]
		git push
	else if [ $TYPE = "hg" ]
		hg push
	else
		echo $TYPE
	end
end

function pull
	set TYPE (repotype)
	if [ $TYPE = "git" ]
		git pull
	else if [ $TYPE = "hg" ]
		hg pull
		hg update
	else
		echo $TYPE
	end
end

function fetch
	set TYPE (repotype)
	if [ $TYPE = "git" ]
		git fetch
	else if [ $TYPE = "hg" ]
		hg pull
	else
		echo $TYPE
	end
end

function rstat
	set TYPE (repotype)
	if [ $TYPE = "git" ]
		git status
	else if [ $TYPE = "hg" ]
		hg status
	else
		echo $TYPE
	end
end

function glog
	set TYPE (repotype)
	if [ $TYPE = "git" ]
		git glog $argv
	else if [ $TYPE = "hg" ]
		hg glog $argv
	else if [ $TYPE = "" ]
		echo $TYPE
	end
end

function glogl
	git glogl $argv
end

# file management
function ll
	ls -la $argv
end

function lf
	ll | grep $argv[1]
end

function rv
	rm --verbose $argv
end

function rd
	rv -rf $argv
end

function cl
	if cd $argv
		ls
	end
end
