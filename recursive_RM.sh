#!/bin/bash

# Created by: Ian Granger
# github repo: https://github.com/icgranger9/recursive_RM

# Purpose: this script is meant to deal with duplicate files, when using ____ and ____.
# Functionality: It compares two directories, and recursively checks for matching files, 
#                where the files in d1 have _HIDDEN~ appended to the name. It then deletes 
#                both matching files.

# --------------------- begin script ------------------------------------------------------

#change IFS from spaces to ; This allows spaces in the file names	
old_IFS=$IFS
IFS=$';'

#puts the time in the logs
echo `date` >> log.ian
echo `date` >> deleted.ian

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
					echo "		Calling resursive with ${item1##*/} ${item2##*/}" >> log.tx
					recursive_check "$item1" "$item2"
				fi
			else
				if [ "${item1##*/}" = "${item2##*/}" ]
				then			
					echo "		match for ${item1##*/} in $item1" >> deleted.ian
					rm $item1
				fi
			fi
		done
	done
}

# replace .public and .hidden with the absolute paths to the two different directories
recursive_check ./public ./hidden


IFS=$old_IFS
