#!/bin/bash

DOWNLOAD_URL=$(curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -s -L -A "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; BEDROCK-UPDATER)" https://minecraft.net/en-us/download/server/bedrock/ |  grep -o 'https://www.minecraft.net/bedrockdedicatedserver/bin-linux/[^"]*')

wget $DOWNLOAD_URL -O ~/bedrock-server.zip --no-check-certificate -U 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.27 Safari/537.17'

unzip -o bedrock*server*.zip

rm -f bedrock*server*.zip

exit 0
