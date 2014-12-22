# vim : set ft=bash
## It's a TRAP
if [[ -x =ack ]]; then
	TRAPINT() {
		echo;ack --bar | sed "y/ge/ta/"
		return $(( 128 + $1 ))
	}
fi


