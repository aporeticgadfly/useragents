#!/bin/bash

#Desc: count number of page requests for given IP address
#Usage: pagereq: <ip address> < inputfile

declare -a PAGE
declare -a COUNT
declare -i X
X=0

while read addr d1 d2 datim gmtoff getr page therest
do
        if [[ $1 == $addr ]]
        then
		for((i=0;i<=$X;i++))
		do
			VAR=0
			if [[ $page == ${PAGE[$i]} ]]
			then
				((COUNT[$i]= ${COUNT[$i]}+1))
				((VAR = $VAR + 1))
				break
			fi
		done
		if [[ $VAR == 0 ]]
               	then

    			((X=$X + 1))
                        PAGE[$X]=$page
			((COUNT[$X]= ${COUNT[$X]} + 1))
		fi

        fi
done

for((i=0;i<${#PAGE[@]};i++))
do
	printf "%s   " "${COUNT[$i]}"
	printf "%s" "${PAGE[$i]}"
	printf "\n"
done
