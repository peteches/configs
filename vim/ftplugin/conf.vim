let b:switch_definitions =
	\ [
	\ {
	\	'^# \(CONFIG_[^ ]\+\) is not set': '\1=y',
	\	'^\(CONFIG_[^ ]\+\)=y': '\1=m',
	\	'^\(CONFIG_[^ ]\+\)=m': '# \1 is not set',
	\ },
	\ ]
