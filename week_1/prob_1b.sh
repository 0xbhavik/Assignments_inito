#! /bin/bash

cat web-server.log | awk -F " " '{print $9}' | sort | uniq -c | awk '{print $2 ": " $1}' > output_prob_1b.txt
