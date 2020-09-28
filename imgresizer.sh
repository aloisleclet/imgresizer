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
    F=$(echo $X / $MAXX | bc -l)
    X=$MAXX
    Y=$(echo $Y / $F | bc)
  elif [[ X -lt Y ]]; then #portrait
    MODE="portrait"
    F=$(echo $Y / $MAXY | bc -l)
    Y=$MAXY
    X=$(echo $X / $F | bc)
  fi

  #minification
  echo "minification of ${IMG} :         ${IX}x${IY} -> ${X}x${Y} - ${MODE}"
  convert "${IMG}" -resize "${X}x${Y}" "./min/${IMG}"


  # todo:
  # check weight while it > max compresse 10% ?


done

echo "Well done :)"
rm -rf ./.tmp
