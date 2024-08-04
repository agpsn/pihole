#!/bin/bash
clear

#check if any urls exist in urls.txt, exit if none found, show count if found
	echo "Checking if any URL's exist in urls.txt"
	declare -i URL_COUNT=0; URL_COUNT=$(cat urls.txt | grep -v ^"#" | grep -v "^$" | wc -l)
	[[ $URL_COUNT == "0" ]] && echo "No URL's Detected. Exiting" && exit 1
	[[ ! -z $URL_COUNT ]] && echo "Found $URL_COUNT URL's."

#remove duplicate urls
	echo "Removing duplicates"
	cat urls.txt | sort -u > urls-sorted.txt

#put contents of each url into a file, excluding any line starting with # or empty line
	echo "Exporting contents of each url"
	for URL in $(cat urls-sorted.txt | grep -v ^"#" | grep -v "^$"); do wget -O- -q $URL >> blocklist2.txt; done && rm -f urls-sorted.txt


#split files into 24Mb sizes (blocklist-00, blocklist-01, etc)
#	echo "Splitting files into 24MB (blocklist-00, blocklist-01, blocklist-02, etc)"
#	mkdir -p adlist; cd adlist; split -C 24m --numeric-suffixes ../blocklist2.txt blocklist-; cd ..

#add large file to github LFS
	git lfs track blocklist2.txt

#github updating
	#git add . && git commit -m "Updated" && git push

exit 0
