#!/bin/bash

declare -A cnt
while read id count
do
	let cnt[$id]+=$count
done
for id in "${!cnt[@]}"
do
	printf "%-15s %8d\n" "${id}" "${cnt[${id}]}"
done
