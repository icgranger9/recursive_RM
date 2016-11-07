#!/bin/bash

# Created by: Ian Granger
# github repo: https://github.com/icgranger9/recursive_RM

# Purpose: this script is meant to deal with duplicate files, when using ____ and ____.
# Functionality: It compares two directories, and recursively checks for matching files, 
#                where the files in d1 have _HIDDEN~ appended to the name. It then deletes 
#                both matching files.

# --------------------- begin script ------------------------------------------------------

#changes IFS, to deal with spaces in file names
old_IFS=$IFS
IFS=$';'

#add the date to the logs
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
