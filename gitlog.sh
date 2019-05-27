#!/bin/sh 
git log --pretty=format:"%ae %ad %h " --date=iso --after=2018 --author=torvalds@linux-foundation.org | sort -k 2
