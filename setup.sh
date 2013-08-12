#! /bin/bash

## Setup script links in all configs found in ~/.peteches_configs to their expected locations. deleted any existing configs found.


if ! [[ -x $( type -P readlink ) ]]; then
	echo "Must install readlink for setup to work" >&2
	exit 1
fi

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 [ install | uninstall ]"
	exit 1
fi

if [[ $1 == install ]]; then
	_install=true
else
	_install=""
fi


config_dir=$(dirname $(readlink -e $0))

[[ -d ~/.vim ]] && rm -rf ~/.vim
if [[ -n $_install ]]; then
	ln -s ${config_dir}/vim/ ~/.vim
fi

[[ -w ~/.vimrc ]] && rm -f ~/.vimrc
if [[ -n $_install ]]; then
	ln -s ${config_dir}/vimrc ~/.vimrc
fi

[[ -d ~/.bash ]] && rm -rf ~/.bash
if [[ -n $_install ]]; then
	ln -s ${config_dir}/bash ~/.bash
fi

[[ -w ~/.bashrc ]] && rm -rf ~/.bashrc
if [[ -n $_install ]]; then
	ln -s ${config_dir}/bashrc ~/.bashrc
fi

[[ -f ~/.tmux.conf ]] && rm -f ~/.tmux.conf
if [[ -n $_install ]]; then
	ln -s ${config_dir}/tmux.conf ~/.tmux.conf
fi

read -p "Install Powerline? [y/N]" INSTALL_POWERLINE

if [[ $INSTALL_POWERLINE -eq y ]]; then

	cd $config_dir/powerline-srcs
	echo "Updating sources:"
	for i in *; do
		echo "updating $i"
		cd $i && git pull && cd -
	done

	echo "installing powerline"
	cd powerline/ && \
	sudo python setup.py install && \
	cd -
	[[ $? -ne 0 ]] &&  echo "Failed" && exit 1

	echo "Installing powerline-daemon"
	cd powerline-daemon/ && \
	sudo python setup.py install && \
	cd -
	[[ $? -ne 0 ]] &&  echo "Failed" && exit 1

	[[ -d ~/.fonts ]] || mkdir -p ~/.fonts

	echo "linking in powerline fonts"
	cd $config_dir/powerline-fonts
	for i in *;do 
		[[ -L ~/.fonts/${i} ]] && rm -fr ~/.fonts/${i}
		ln -sf $config_dir/powerline-fonts/$i ~/.fonts/$i
	done
	echo "refreshing font cache"
	fc-cache -vf ~/.fonts


	[[ -d ~/.config/powerline || -L ~/.config/powerline ]] && rm -rf ~/.config/powerline
	if [[ -n $_install ]]; then
		ln -s ${config_dir}/powerline ~/.config/powerline
	fi

fi
