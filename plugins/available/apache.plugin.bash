cite about-plugin
about-plugin 'apache tools'

ips ()
{
    about 'display all Apache log files with the question which one to tail'
    group 'base'
    files=(/var/log/apache2/*log)

	sorthelper=();
	for file in "${files[@]}"; do
	    # We need something that can easily be sorted.
	    # Here, we use "<date><filename>".
	    # Note that this works with any special characters in filenames

	    #sorthelper+=("$(stat -n -f "%Sm%N" -t "%Y%m%d%H%M%S" -- "$file")"); # Mac OS X only
	    # or
	    #sorthelper+=("$(stat --printf "%Y    %n" -- "$file")"); # Linux only
	    sorthelper+=("$(stat --printf "%Y    %n" -- "$file")"); # Linux only
	done;

	sorted=();
	while read -d $'\0' elem; do
	    # this strips away the first 14 characters (<date>)
	    sorted+=("${elem:14}");
	done < <(printf '%s\0' "${sorthelper[@]}" | sort -z)

	# ask which file to tail
	echo ""
	for i in "${!sorted[@]}"; do
	    file=${sorted[i]};

	    echo "  $i. $file";
	done;
	echo "Which file do you want to tail? [0] "
	read choice;

	# tail the file of choice
	tail -f ${sorted[$choice]} &
}

