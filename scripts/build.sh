#!/bin/bash -

steal_build()
{
	java -Xmx512m -Xss1024k -cp $CP org.mozilla.javascript.tools.shell.Main -e _args=$(cat $2) -opt -1 -e 'load('"'"$1"'"')'
}

prod1()
{
	sed_script=$( mktemp )

	cat <<-EOF > $sed_script
	s@steal\(({src:[[:blank:]]*\("\|'\)packages/0\.js\('\|"\)@steal.loaded\1@g
	s@\(steal([^.]*\)\(\.css\('|"\)\)@\1/production\2@g
EOF

	for appname in ${@}; do
		sed -i -f $sed_script $appname/production.js
	done

	cat <<-EOF > $sed_script
	s@steal\((src:[[:blank:]]*\('\|"\)os/production\.css\2\)@steal.loaded\1@g
EOF
	sed -i -f $sed_script os/production.js

	cat <<-EOF > ${sed_script}
	s@\(steal/steal\)\(.js\)@\1.production.\2@g
	s@</head>@<link rel="stylesheet" href="/app/os/production.css" />\n\t&@
EOF
	sed -i -f $sed_script os/templates/default.php

	rm -f $sed_script
}

backup_controllers()
{

	case $x in
		backup	)
			for i in widget layout theme; do
				if [[ -f file/${i} ]]; then
					mv file/${i} file/${i}~
					ln -s ../../internal/${i} file/
				else
					return 1
				fi
			done
		;;
		restore	)
			for i in widget layout theme; do
				if [[ -L file/${i} ]]; then
					rm file/${i}
					mv file/${i}~ file/${i}
				else
					return 1
				fi
			done
		;;
	esac
}
