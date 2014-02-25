#!/bin/sh -x

# copy a directory if it doesn't exist on the target
function install-plugin(){
	if [ ! -d ~/.vim/bundle/$1 ]
	then
		cp -r ${BASH_IT}/$1 ~/.vim/bundle/$1
	fi	
}


# paste the .vimrc file
if [ ! -f ~/.vimrc ]; then
	cp .vimrc ~/.vimrc
else
	cp ~/.vimrc ~/.vimrc.backup.${date +'%Y%m%d_%H%M'}
	cp .vimrc ~/.vimrc
fi

# create the autoload directory
if [ ! -d ~/.vim/autoload ]; then
	mkdir -p ~/.vim/autoload
fi

# create the bundle directory
if [ ! -d ~/.vim/bundle ];then
	mkdir -p ~/.vim/bundle
fi

# puth the pathogen script in the autoload dir
if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
	cp pathogen.vim ~/.vim/autoload
fi

# install the various plugins
install-plugin vim-surround
install-plugin nerdtree
install-plugin tcomment_vim
install-plugin emmet-vim
