function croot
	set REPO_DIR (root)
	if [ $REPO_DIR = "No repository was found." ]
		echo $REPO_DIR
	else
		cd (root) $argv
	end
end
