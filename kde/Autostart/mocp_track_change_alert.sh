#!/bin/bash -

# redirect stderr to stdin and close
exec <&2-
# close stdout
exec >&-
# close stdin
exec <&-

alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

mocp=$(/usr/bin/mocp -i)
state=$( echo -e "${mocp}" | /usr/bin/awk -F": "  '/^State/ {print $NF}' )
track=$( echo -e "${mocp}" | /usr/bin/awk -F": " '/^SongTitle/ {print $NF}' )
artist=$( echo -e "${mocp}" | /usr/bin/awk -F": " '/^Artist/ {print $NF}' )
album=$( echo -e "${mocp}" | /usr/bin/awk -F": " '/^Album/ {print $NF}' )

/usr/bin/notify-send "MOCP - ${state}" "$( echo -e "Artist:  ${artist}\nAlbum: ${album}\nTrack:  ${track}")"

while : ; do

	old_track=${track}

	mocp=$(/usr/bin/mocp -i)
	state=$( echo -e "${mocp}" | /usr/bin/awk -F": " '/^State/ {print $NF}' )
	track=$( echo -e "${mocp}" | /usr/bin/awk -F": " '/^SongTitle/ {print $NF}' )
	artist=$( echo -e "${mocp}" | /usr/bin/awk -F": " '/^Artist/ {print $NF}' )
	album=$( echo -e "${mocp}" | /usr/bin/awk -F": " '/^Album/ {print $NF}' )
	length_left=$( echo -e "${mocp}" | /usr/bin/awk -F": " '/^TotalSec/ { total=$NF}
												/^CurrentSec/ { current=$NF}
												END { print total - current }' )
	
	if [[ "${state}" == "PLAY" && "${old_track}" != "${track}" ]]; then
		/usr/bin/notify-send "MOCP - ${state}" "$( echo -e "Artist:\t${artist}\nAlbum:\t${album}\nTrack:\t${track}")"
	fi

	sleep 1

done
