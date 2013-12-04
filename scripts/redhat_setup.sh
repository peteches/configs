#!/bin/bash -uex

# vars

declare -ar COMMANDS=(	"Setup Hostname", \
			"Setup Network", \
			"Join to IPA server", \
			"Reboot", \
			)

declare -f setup_hostname setup_network join_IPA reboot_machine


# functions

# setup_hostname()
#	setup hostname prompts the user for 



# main

select cmd in "${COMMANDS[@]}";do
	case $cmd in 
		"Setup Hostname" )
			setup_hostname
		;;
		"Setup Network" )
			setup_network
		;;
		"Join to IPA server" )
			join_IPA
		;;
		"Reboot" )
			reboot_machine
		;;
	esac
done
