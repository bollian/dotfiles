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
