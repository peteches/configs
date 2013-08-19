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
	ln -s ${config_dir}/powerline-srcs/powerline/powerline/bindings/vim/ ~/.vim/bundle/powerline
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

[[ -f ~/.xsession ]] && rm -f ~/.xsession
if [[ -n $_install ]]; then
	ln -s ${config_dir}/X-configs/xsession ~/.xsession
fi

[[ -f ~/.Xdefaults ]] && rm -f ~/.Xdefaults
if [[ -n $_install ]]; then
	ln -s ${config_dir}/X-configs/Xdefaults ~/.Xdefaults
fi

[[ -f ~/.fonts ]] && rm -f ~/.fonts
if [[ -n $_install ]];then
	ln -s ${config_dir}/powerline/fonts ~/.fonts
	fc-cache -fv ~/.fonts
fi

[[ -d ~/.config/powerline || -L ~/.config/powerline ]] && rm -rf ~/.config/powerline
if [[ -n $_install ]]; then
	ln -s ${config_dir}/powerline ~/.config/powerline
fi

