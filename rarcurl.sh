#!/bin/bash
#
#
#    Downloads and extracts the downloaded rars in the form of r01, r02, etc
#
#    eg.
#
#      ./rarcurl.sh http://210.6.78.117:1337/Star.Wars.Rebels.S01E09.READNFO.HDTV.x264-BATV/star.wars.rebels.s01e09.readnfo.hdtv.x264-batv.r08

str=$1                      # first parameter

path=${str:0:${#str}-4}     # gets the fullpath to download w/o file extension
ten=${str: -2:1}            # gets the last 2 number digits of the fullpath
filename=$(basename "$path")  # gets just the filename from the fullpath

curl -C - -O -L "$path.rar" # Downloads the first rar file

for ((i=0;i<=ten;++i))      # Loops the second digit
do
  for e in $(eval echo {0..9}) # Loops the first digit
  do
    curl -C - -O -L "$path.r$i$e"
  done
done

# extracts the downloaded rar's
unrar e "$filename.rar"

# deletes the downloaded rar's
find "../Peliculas" -type f -name "$filename.r*" -exec rm '{}' +

# downloads the spanish subtitle
file=$(ls -lht | head -2 | tail -1 | awk '{print $9}')
subliminal download -l es -e  utf 8 "$file" "$file"
