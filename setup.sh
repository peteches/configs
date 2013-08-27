#! /bin/bash

## Setup script links in all configs found in ~/.peteches_configs to their
## expected locations. deleted any existing configs found.


if ! [[ -x $( type -P readlink ) ]]; then
	echo "Must install readlink for setup to work" >&2
	exit 1
fi

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 [ install | uninstall ]"
	exit 1
fi

case $1 in
    install )
        _install=true
        ;;
    uninstall )
        _install=false
        ;;
    * )
        while [[ ${REPLY^^} != 'Y' || ${REPLY^^} != 'N' ]]; do
            read -p "install?[y/N] Ctrl-C to quit" REPLY
        done
        if [[ ${REPLY^^} == 'Y' ]]; then
            _install=true
        elif [[ ${REPLY^^} == 'N' ]]; then
            _install=false
        fi
esac

config_dir=$(dirname $(readlink -e $0))

# create backup directory for existing files
backup_dir=${config_dir}/backups

function install_config {
    target=$1
    dest=$2
    if [[ $_install == true ]]; then
        if [[ -e ${dest} ]]; then
            [[  -d ${backup_dir} ]] || mkdir -p ${backup_dir}
            mv --backup=numbered ${dest} ${backup_dir}
        fi
        ln -s ${target} ${dest}
    elif [[ $_install == false ]]; then
        if [[ ! -L ${dest} ]]; then
            read -p "${dest} is not a symlink really delete? [y/N]: " delete
        fi
        if [[ ${delete^^} == 'N' ]]; then
            echo "exiting"
            exit 0
        fi
        rm -f ${dest}
        mv ${backup_dir}/$( basename ${dest} ) ${dest}
    fi
}

config_matrix=(
    "${config_dir}/awesome ${HOME}/.config/awesome"
    "${config_dir}/vim ${HOME}/.vim"
    "${config_dir}/vimrc ${HOME}/.vimrc"
    "${config_dir}/powerline-srcs/powerline/powerline/bindings/vim/ ${HOME}/.vim/bundle/powerline"
    "${config_dir}/powerline ${HOME}/.config/powerline"
    "${config_dir}/powerline/fonts ${HOME}/.fonts"
    "${config_dir}/X-configs/Xdefaults ${HOME}/.Xdefaults"
    "${config_dir}/X-configs/xsession ${HOME}/.xsession"
    "${config_dir}/tmux ${HOME}/.tmux"
    "${config_dir}/tmux.conf ${HOME}/.tmux.conf"
    "${config_dir}/bashrc ${HOME}/.bashrc"
    "${config_dir}/bash ${HOME}/.bash"
    "${config_dir}/vimrc ${HOME}/.vimrc"
)

for args in "${config_matrix[@]}"; do
    install_config ${config_matrix[0]}
done
exit $?
