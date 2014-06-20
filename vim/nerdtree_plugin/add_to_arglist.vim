if exists("g:loaded_nerdtree_arglist_keymap")
	finish
endif
let g:loaded_nerdtree_arglist_keymap = 1

call NERDTreeAddKeyMap({
			\ 'key': 'a',
			\ 'callback': "NerdAddArgList",
			\ 'quickhelpText': 'Adds file to arglist.',
			\ 'scope': 'FileNode' })

function! NerdAddArgList(node)
	if a:node != {}
		redir => argumentlist
		args
		redir END
		let l:f = a:node.path.str()
		" Don't add to file if it's already in the arglist.
		if match(argumentlist, '[ \[]' . l:f . '[ \]]') == -1
			execute "argadd " . l:f
		endif
	endif
endfunction

