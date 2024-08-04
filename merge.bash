#!/bin/bash
clear

URL_COUNT=$(cat urls.txt | grep -v ^"#" | grep -v "^$" | wc -l)

[[ -z $URL_COUNT ]] && echo "No URL's Detected. Exiting" && exit 1

while [[ $count -lt $URL_COUNT ]] ; do
	for URL in $(cat urls.txt | grep -v ^"#" | grep -v "^$"); do
		  (( count += 1 ))
		echo "$count: "$URL
		echo $URL >> urls-output.txt
	done
done

#duplicate check
cat urls-output.txt | sort -u > blocklist2.txt && rm urls-output.txt

exit 0
