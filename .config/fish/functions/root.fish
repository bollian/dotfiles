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
