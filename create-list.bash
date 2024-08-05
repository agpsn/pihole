#!/bin/bash
# shellcheck disable=SC2002
clear; set -eu

#urls.txt	= list of adblock url lists
#.list1		= sorted urls.txt
#.list2		= no comments/empty lines urls.txt
#.list3		= contents of lists
#.list4		= no comments/empty lines .list3
#pihole.txt	= sorted .list3, final output

	rm -rf .list1 .list2 .list3 .list4
	[[ -f "urls.txt" ]] && sort -u < urls.txt >> .list1
	[[ -f ".list1" ]] && cat .list1 | grep -v ^"#" | grep -v "^$" >> .list2
	[[ -f ".list2" ]] && while read -r URL; do echo "Processing $URL" && wget -O- -q "$URL" >> .list3; done < .list2
	[[ -f ".list3" ]] && cat .list3 | grep -v ^"#" | grep -v "^$" >> .list4
	[[ -f ".list4" ]] && sort -u < .list4 >> pihole.txt
	rm -rf .list1 .list2 .list3 .list4

exit 0
