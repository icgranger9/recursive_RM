#!/bin/bash

#created by Ian Granger
#a Recursive script, to check the contense of a directory, find matches in another directory, and check any nested directories.

#change from spaces to ;
old_IFS=$IFS
IFS=$';'

#puts the time in the logs
echo `date` >> ian_log.txt
echo `date` >> ian_delete.txt

recursive_check ()
{
	for item1 in $1/*
	do
		for item2 in $2/*
		do
			if [ -d "$item1" ]
			then
				if [ "${item1##*/}" = "${item2##*/}" ]
			then
					echo "		Calling resursive with ${item1##*/} ${item2##*/}" >> ian_log.txt
					recursive_check "$item1" "$item2"
				fi
			else
				if [ "${item1##*/}" = "${item2##*/}" ]
				then			
					echo "		match for ${item1##*/} in $item1" >> ian_delete.txt
					rm $item1
				fi
			fi
		done
	done
}

recursive_check ./public ./hidden


IFS=$old_IFS
