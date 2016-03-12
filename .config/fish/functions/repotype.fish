function repotype
	if git rev-parse --show-toplevel > /dev/null 2> /dev/null
		echo "git"
	else if hg root > /dev/null 2> /dev/null
		echo "hg"
	else
		echo "No repository was found."
	end
end
