#!/bin/bash


COUNT=0

while true
do
	echo "debug loop: ${COUNT} seconds"
	sleep 5
	COUNT=$((COUNT + 5))
done