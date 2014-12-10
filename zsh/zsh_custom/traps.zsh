# vim : set ft=bash
## It's a TRAP
if [[ -x =ack ]]; then
    trap "echo;ack --bar | sed 'y/ge/ta/'" SIGINT
fi


