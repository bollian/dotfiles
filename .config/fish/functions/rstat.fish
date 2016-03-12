function rstat
	set TYPE (repotype)
	if [ $TYPE = "git" ]
		git status $argv
	else if [ $TYPE = "hg" ]
		hg status $argv
	else
		echo $TYPE
	end
end
