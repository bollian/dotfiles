function fetch
	set TYPE (repotype)
	if [ $TYPE = "git" ]
		git fetch $argv
	else if [ $TYPE = "hg" ]
		hg pull $argv
	else
		echo $TYPE
	end
end
