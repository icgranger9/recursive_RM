#!/bin/bash

# Created by: Ian Granger
# github repo: https://github.com/icgranger9/recursive_RM

# Purpose: this script is meant to deal with duplicate files, when using unsionFS and AWS.
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
	# goes through all emelents in in the first arg, which is originally ./public
	for item1 in $1/*
	do
		#goes throught all elements in in the second arg, which is originally ./hidden
		for item2 in $2/*
		do
			#if the item in $1 is a diretory, add it to the log, and call the function again, checking all items in the directory
			if [ -d "$item1" ]
			then
				#double check that there is a matching directory in $2, just to be safe
				if [ "${item1##*/}" = "${item2##*/}" ]
			then
					echo "		Calling resursive with ${item1##*/} ${item2##*/}" >> log.ian
					recursive_check "$item1" "$item2"
				fi
			else
				#if it's not a directory, then it must be a file
					#check that the files are matching, except for the _HIDDEN~
					#to make the files be exact matches, simply remove the _HIDDEN~ from the first statement.
				if [ "${item1##*/}_HIDDEN~" = "${item2##*/}" ]
				then
					#saves in to te log, and deletes the two files.
					echo "		match for ${item1##*/} in $item1" >> deleted.ian
					rm $item1
					rm $item2
				fi
			fi
		done
	done
}

# replace .public and .hidden with the absolute paths to the two different directories
	#./public is the directory with files that end in _HIDDEN~
recursive_check ./public ./hidden

#sets the IFS back to what it was originally.
	#not sure this is needed, but I included it to be safe.
IFS=$old_IFS
