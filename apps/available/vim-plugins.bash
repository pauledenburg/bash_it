#!/bin/bash 
#
# This file is executed everytime the user logs in (and this app is enabled)

# backup the .vim directory if it already exists
if [ -d ~/.vim ]
then
	mv ~/.vim ~/.vim.backup
fi

# create a symlink to the vim directory if it doesn't
# exist yet
if [ ! -h ~/.vim ]
then
	#cp -r ${BASH_IT}/files/vim/$1 ~/.vim/bundle/$1
	ln -s ${BASH_IT}/files/vim ~/.vim
fi	

# backup an existing .vimrc file
if [  -e ~/.vimrc ]; then
	mv ~/.vimrc ~/.vimrc.backup
fi

# create a symlink to the .vimrc file when needed
if [ ! -h ~/.vimrc ]; then
	#cp .vimrc ~/.vimrc
	ln -s ${BASH_IT}/files/.vimrc ~/.vimrc
fi
