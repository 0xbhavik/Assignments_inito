#! /bin/bash

cat web-server.log| awk -F " " '{if ($9=="200"){print $9} }' | wc -l


