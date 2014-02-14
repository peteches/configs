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
            if [[ -L ${dest} ]]; then
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
    "${config_dir}/gitconfig ${HOME}/.gitconfig"
)

# add scripts individually so as to keep locally generated scripts.
for script in ${config_dir}/scripts/*; do
    config_matrix+=( "${script} ${HOME}/bin/$( basename ${script} )" )
done

# Also add kde things seperately to keep local scripts in tact.
for file in $( find ${config_dir}/kde -type f -printf "%P "); do
    config_matrix+=( "${config_dir}/kde/${file} ${HOME}/.kde/${file}")
done

# and the same for firefox things, although more complicated as the 
# profile directory will have a random 8 character string infrom of the
# profile name.

for file in $( find "${config_dir}/firefox" -type f -printf "%P "); do
    # potentially this could match multiple paths, old profiles backups etc.
    profile=$( echo $file | cut -d/ -f1)
    dst_paths=($(find "${HOME}/.mozilla/firefox" \
                    -maxdepth 1 \
                    -type d -name \*.${profile} \
                    -print))
    if [[ ${#dst_paths[@]} -gt 1 ]]; then
        # we did find multiple profiles
        for i in ${!dst_paths[@]}; do
            if [[ $i -eq ${#dst_paths[@]} ]];then
                break  # no element i+1 now, need to vamoose before we error.
            fi

            # here we chaeck to see which is newer and assume that the most
            # recent is the correct one.
            if [[ ${dst_paths[$i]} -nt ${dst_paths[$i+1]} ]]; then
                dst=${dst_paths[$i]} 
            else
                dst=${dst_paths[$i+1]} 
            fi
        done
    else
        dst=${dst_paths[0]}
    fi 

    dst_path=${dst}/${file#*/} #strip profile name

    config_matrix+=("${config_dir}/firefox/${file} ${dst_path}")
done


for args in "${config_matrix[@]}"; do
    install_config $args
done

if [[ $_action == install ]]; then
    echo "initialising submodules"
    cd ${config_dir} && git submodule init && git submodule update
fi
exit $?
