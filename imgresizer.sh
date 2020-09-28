#!/bin/bash

IMGS=$@

MAXX=1080
MAXY=960

FORMAT=0

echo "img4web"
echo "minimalist image resizer for the web."
echo " "

mkdir ./.tmp
mkdir ./min 

for IMG in "$@";
do
  # get resolution
  identify $IMG > ./.tmp/identify
  cut -f 3 -d ' ' ./.tmp/identify > ./.tmp/res
  X=$(cut -f 1 -d 'x' ./.tmp/res)
  Y=$(cut -f 2 -d 'x' ./.tmp/res)
  IX=$X
  IY=$Y
  
  # check if format portrait or landscape

  if [[ X -ge Y ]]; then #landscape
    MODE="landscape"
    X=$(expr $X - $( expr $(expr $MAXX - $X) \* -1))
    Y=$(expr $Y - $( expr $(expr $MAXX - $X) \* -1))
  elif [[ X -lt Y ]]; then #portrait
    MODE="portrait"
    X=$(expr $X - $(expr( $(expr $MAXY - $Y) \* -1)))
    Y=$(expr $Y - $(expr( $(expr $MAXY - $Y) \* -1)))
  fi

  #minification
  echo "minification of ${IMG} :         ${IX}x${IY} -> ${X}x${Y} - ${MODE}"
  convert "${IMG}" -resize "${X}x${Y}" "./min/${IMG}"

  # check if resolution is > a max variable

  # resize to max value

  # check weight while it > max compresse 10% ?


done

echo "Well done :)"
rm -rf ./.tmp
