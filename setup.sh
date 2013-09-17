#! /bin/bash

## Setup script links in all configs found in ~/.peteches_configs to their
## expected locations. deleted any existing configs found.

# usage()
#	prints usage
#
# inputs	-
# outputs	- usage message
# return value	- 0 if successfull
# side effects	-
usage()
{
    echo "Usage: $0 [ install | uninstall | update ]"
}

if ! [[ -x $( type -P readlink ) ]]; then
	echo "Must install readlink for setup to work" >&2
	exit 1
fi

if [[ $# -ne 1 ]]; then
    usage
	exit 1
fi

case $1 in
    install )
        ;&
    update )
        ;&
    uninstall )
        _action=$1
        ;;
    * )
        usage
        exit 1
        ;;
esac

config_dir=$(dirname $(readlink -e $0))

# create backup directory for existing files
backup_dir=${config_dir}/backups

function install_config {
    target=$1
    dest=$2

    case $_action in
        update )
            if [[ -e ${dest} ]]; then
                return
            fi
            ;&  # execute the install code block as well
        install )
            if [[ -e ${dest} ]]; then
                [[  -d ${backup_dir} ]] || mkdir -p ${backup_dir}
                mv --backup=numbered ${dest} ${backup_dir}
            fi
            # ensure target dir exists.
            [[ -d $( dirname ${dest} ) ]] || mkdir --parents $( dirname ${dest} )
            ln -s ${target} ${dest}
            ;;
        uninstall )
            if [[ ! -L ${dest} ]]; then
                read -p "${dest} is not a symlink really delete? [y/N]: " delete
            fi
            if [[ ${delete^^} == 'N' ]]; then
                echo "exiting"
                exit 0
            fi
            rm -f ${dest}
            mv ${backup_dir}/$( basename ${dest} ) ${dest}
            ;;
    esac

}

config_matrix=(
    "${config_dir}/X-configs/Xdefaults ${HOME}/.Xdefaults"
    "${config_dir}/X-configs/xsession ${HOME}/.xsession"
    "${config_dir}/awesome ${HOME}/.config/awesome"
    "${config_dir}/bash ${HOME}/.bash"
    "${config_dir}/bash/bashrc ${HOME}/.bashrc"
    "${config_dir}/misc/mailcap ${HOME}/.mailcap"
    "${config_dir}/mutt ${HOME}/.mutt"
    "${config_dir}/mutt/muttrc ${HOME}/.muttrc"
    "${config_dir}/powerline ${HOME}/.config/powerline"
    "${config_dir}/powerline-srcs/powerline/powerline/bindings/vim/ ${HOME}/.vim/bundle/powerline"
    "${config_dir}/powerline/fonts ${HOME}/.fonts"
    "${config_dir}/tmux ${HOME}/.tmux"
    "${config_dir}/tmux/tmux.conf ${HOME}/.tmux.conf"
    "${config_dir}/vim ${HOME}/.vim"
    "${config_dir}/vim/vimrc ${HOME}/.vimrc"
)

# add scripts individually so as to keep locally generated scripts.
for script in ${config_dir}/scripts/*; do
    config_matrix+=( "${script} ${HOME}/bin/$( basename ${script} )" )
done

for args in "${config_matrix[@]}"; do
    install_config $args
done

if [[ $_action == install ]]; then
    echo "initialising submodules"
    cd ${config_dir} && git submodule init && git submodule update
fi
exit $?
