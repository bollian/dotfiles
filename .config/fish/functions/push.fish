function push
	set TYPE (repotype)
	if [ $TYPE = "git" ]
		git push $argv
	else if [ $TYPE = "hg" ]
		hg push $argv
	else
		echo $TYPE
	end
end
