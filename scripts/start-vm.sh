#! /bin/bash

# usage()
#	prints usage
#
# inputs	- vm_name name
# outputs	-
# return value	- 0 if successfull
# side effects	- starts spice viewer
usage()
{
    echo "$0 <vm_name name>"
}

declare vm_name=$1

if [[ -z $vm_name ]]; then
    usage >&2
    exit 1
fi

declare vm_state="$( sudo virsh list --all | awk -v vm="$vm_name" '$2 == vm { print $3 }')"

case $vm_state in
    shut )
        sudo virsh start $vm_name
    ;;

    paused )
        sudo virsh resume$vm_name
    ;;
    running )
        : # do nothing allready running
    ;;
    *)
        echo "Unknown State: $vm_state" >&2
        exit 1
    ;;
esac

sudo virt-viewer --attach --wait $vm_name &> /dev/null &

if [[ $? -ne 0 ]]; then
    echo "Error startting virt-viewer" >&2
    exit 1
fi

disown

