if !has('python3')
	finish
endif

function! s:ValidateJson(type, ...)
	let sel_save = &selection
	let &selection = "inclusive"

	py3file json-validator.py

	let &selection = sel_save
endfunc

hi JSONValidateError ctermbg=red

nnoremap <silent> <Plug>ValidateJSON :<C-U>set opfunc=<SID>ValidateJson<CR>g@
vnoremap <silent> <Plug>ValidateJSON :<C-U>call <SID>ValidateJson(visualmode()), 1)<CR>

vnoremap <silent> <Plug>ValidateJSON :<C-U>call <SID>ValidateJson(visualmode(), 1)<CR>
if !exists("g:validate_json_no_mappings") || ! g:validate_json_no_mappings
	nmap gj <Plug>ValidateJSON
	vmap gj <Plug>ValidateJSON
endif
