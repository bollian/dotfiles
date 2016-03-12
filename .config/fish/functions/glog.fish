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
