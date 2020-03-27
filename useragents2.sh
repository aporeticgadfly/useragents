#!/bin/bash

#Desc: read through log looking for unknown user agents
#Usage: ./useragents.sh -f inputfile -s hostsfile

function mismatch () {
	local -i i
	for((i=0;i<$KNSIZE; i++))
	do
		[[ "$1" =~ .*${KNOWN[$i]}.* ]] && return 1
	done
	return 0
}

INPUTFILE="accesslog"
HOSTSFILE="useragents.txt"

while getopts 'f:s:' opt
do
	case  "${opt}" in
		f) INPUTFILE=${OPTARG}
			;;
		s) HOSTSFILE=${OPTARG}
			echo "test"
			;;
		*) echo "usage: ./useragents.sh -f inputfile -s hostsfile"
			exit 2
			;;
	esac
done

readarray -t KNOWN < ${HOSTSFILE}
KNSIZE=${#KNOWN[@]}

awk -F'"' '{print $1, $6}' | \
while read ipaddr dash1 dash2 dtstamp delta useragent
do
	if mismatch "$useragent"
	then
		echo "anomaly: $ipaddr $useragent"
	fi
done < ${INPUTFILE}
