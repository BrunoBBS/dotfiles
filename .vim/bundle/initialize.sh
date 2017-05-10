#!/bin/sh

for plugin in $(cat ~/.vimrc | grep -e "^Plugin" | cut -f 2 -d " " | sed "s/'//g")
do
	echo "$plugin"
	git submodule add https://github.com/$plugin.git
done 
