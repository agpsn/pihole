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

cat urls-output.txt | sort -u > urls-sorted.txt && rm urls-output.txt

for URL in $(cat urls-sorted.txt | grep -v ^"#" | grep -v "^$"); do wget -O- -q $URL >> blocklist2.txt; done && rm -f urls-sorted.txt

split -C 24m --numeric-suffixes blocklist2.txt blocklist-

mkdir adlist

mv blocklist-* adlist/

exit 0
