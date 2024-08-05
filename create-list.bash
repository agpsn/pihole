#!/bin/bash
# shellcheck disable=SC2002
clear; set -eu

#urls.txt	= list of adblock url lists
#.list1		= sorted urls.txt
#.list2		= no comments/empty lines urls.txt
#.list3		= contents of lists
#.list4		= no comments/empty lines .list3
#.list5		= sorted .list3

	rm -rf .list1 .list2 .list3 .list4 .list5

	[[ -f "urls.txt" ]] && sort -u < urls.txt >> .list1
	[[ -f ".list1" ]] && cat .list1 | grep -v ^"#" | grep -v "^$" >> .list2
	[[ -f ".list2" ]] && while read -r URL; do echo "Processing $URL" && wget -O- -q "$URL" >> .list3; done < .list2
	[[ -f ".list3" ]] && cat .list3 | grep -v ^"#" | grep -v "^$" >> .list4
	[[ -f ".list4" ]] && sort -u < .list4 >> .list5





##order: urls.txt >> .list1 >> .list2 >> .list3 >> .list4 >> .list5 >> pihole.txt

##backup existing
##	if [[ -f "pihole.txt" ]]; then 	mkdir -p archive && mv pihole.txt archive/$(date -u +"%Y-%m-%d_%H:%M:%S_%Z")-pihole.txt; fi

##cleanup (pre)
#	rm -f .list1 .list2 .list3 .list4 .list5

##check if any urls exist in urls.txt, exit if none found, show count if found
#	echo "Checking if any URL's exist in input file (urls.txt)"
#	declare -i URL_COUNT=0; URL_COUNT=$(cat urls.txt | grep -c -v ^"#" | grep -v "^$")
#	[[ $URL_COUNT == "0" ]] && echo "No URL's Detected. Exiting" && exit 1
#	[[ -n $URL_COUNT ]] && echo "Found $URL_COUNT URL's."

##remove duplicate urls
#	echo "Removing duplicate URL's"
#	sort -u < urls.txt > .list1

##put contents of each url into a file, excluding any line starting with # or empty line
#	echo "Exporting contents of each URL"
#	while read -r URL; do echo "Processing $URL" && wget -O- -q "$URL" >> .list2; done < .list1

##sort and clean output
#	echo "Sorting and Cleaning output"
#	cat .list2 | sort -u > .list3
#	while read -r URL2; do echo "Processing $URL2"; echo "$URL2" >> .list4; done <.list3
#	cat .list4 | sort -u > .list5 && cat .list5 | grep -v ^"#" | grep -v "^$" >> pihole.txt

##cleanup (post)
#	rm -f .list1 .list2 .list3 .list4 .list5

exit 0
