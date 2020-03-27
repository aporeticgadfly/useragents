#!/bin/bash

declare -A cnt
while read id xtra
do
	let cnt[$id]++
done

for id in "${!cnt[@]}"
do
	printf '%s %d\n' "$id" "${cnt[$id]}"
done
