#! /bin/bash

cat web-server.log | awk -F " " '{print $9}' | sort | uniq -c | awk '{print $2 ": " $1}'
