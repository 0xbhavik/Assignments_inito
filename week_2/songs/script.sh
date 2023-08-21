#! /bin/bash

echo "" > playlists.txt

echo "Type no. of songs in your playlist" 
read songsNo

for x in $(seq 1 $songsNo)
do
 mins=$(($RANDOM%30))
 secs=$(($RANDOM%60))
 echo "$mins min $secs sec "
 echo $((($mins*60)+secs)) >>  playlists.txt
done

echo "Type how many mins you wanna listen?"
read totMins
echo $totMins

