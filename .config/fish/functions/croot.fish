function croot
	set REPO_ROOT (bash -i -c "croot $argv")
	if test (echo $status) -eq "0"
		cd $REPO_ROOT
	end
end
