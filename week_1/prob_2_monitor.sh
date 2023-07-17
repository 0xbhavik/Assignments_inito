#! /bin/bash

bash $1 &
pid_=$!

while true;
do

isExist=$(ps axo pid | grep $pid_ | wc -w)

if [[ $isExist -eq "0" ]];
then
 
echo "process stopped, starting it again"
bash $1 &
pid=$!

else 
echo "process is already running"

fi

sleep 3

done
