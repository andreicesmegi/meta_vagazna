  GNU nano 5.8                                                                                                   meta_vaganza.sh                                                                                                             
#!/bin/bash


echo "insert domain bellow: "
read domain

#The section bellow clears tmp/meta1 directory for new results. Keeping computer clean.
rm -rf /tmp/meta1 &>/dev/null
mkdir /tmp/meta1 && cd /tmp/meta1

# The section bellow google searches for files within the given domain and saves it on meta_vaganza file.
lynx --dump "https://google.com/search?q=site: ${domain} +ext:pdf" | grep ".pdf" | cut -d "=" -f 2 | egrep -v "site|google" | sed 's/...$//' >> /tmp/meta1/meta_vaganza 2>/dev/null
lynx --dump "https://google.com/search?q=site: ${domain} +ext:doc" | grep ".doc" | cut -d "=" -f 2 | egrep -v "site|google" | sed 's/...$//' >> /tmp/meta1/meta_vaganza 2>/dev/null
lynx --dump "https://google.com/search?q=site: ${domain} +ext:txt" | grep ".txt" | cut -d "=" -f 2 | egrep -v "site|google" | sed 's/...$//' >> /tmp/meta1/meta_vaganza 2>/dev/null
lynx --dump "https://google.com/search?q=site: ${domain} +ext:ppt" | grep ".ppt" | cut -d "=" -f 2 | egrep -v "site|google" | sed 's/...$//' >> /tmp/meta1/meta_vaganza 2>/dev/null
lynx --dump "https://google.com/search?q=site: ${domain} +ext:xml" | grep ".xml" | cut -d "=" -f 2 | egrep -v "site|google" | sed 's/...$//' >> /tmp/meta1/meta_vaganza 2>/dev/null

#The section bellow downloads all files from meta_vaganza file after filtering.
for url in $(cat meta_vaganza);
do
wget -q $url /tmp/meta1
done

#The section bellow saves the downloaded files into file_meta file.
cat meta_vaganza | cut -d "/" -f 5 > /tmp/meta1/file_meta

#The section bellow executes exiftool for metadata search on each file downloaded. And prints on screen.
for file in $(cat file_meta);
do
echo ""
echo "Results"
exiftool $file;
echo ""
done

#The section bellow cleans computer from downloaded files.
#cd ..
#rm -rf /tmp/meta1 &>/dev/null

