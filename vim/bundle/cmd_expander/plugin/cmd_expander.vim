" takes command and looks up full path to it.
" will only work on the word currently under the cursor.
" allowed chars in cmd -_.

" copy iskeyword to old_isk, set iskeyword to allowed chars then call
" ExpandPath function and return to insert mode.
inoremap <leader>f <esc>:let old_isk = &iskeyword<cr>:set iskeyword=@,-,.,_,^;,^/<cr>:call ExpandPath(expand("<cword>"), old_isk)<cr>a
nnoremap <leader>f <esc>:let old_isk = &iskeyword<cr>:set iskeyword=@,-,.,_,^;,^/<cr>:call ExpandPath(expand("<cword>"), old_isk)<cr>

function! ExpandPath(cmd, old_isk)
	"
	:let s:cmd_type = system("bash -c 'type -t " . shellescape(a:cmd) . "'")
	:let s:cmd_type = tr(s:cmd_type, "\n", ' ')

	if s:cmd_type ==# "file "
		" use type to find full path to cmd
		:let s:fullpath = system("bash -c 'type -P " . shellescape(a:cmd) . "'")
		" remove any newlines (type add one tothe end of the var
		: let s:fullpath = substitute(s:fullpath, "\n", '', '')
		:execute "normal viwc" . s:fullpath
	elseif s:cmd_type ==# ""
		:echo a:cmd . " is not in $PATH: " . $PATH
	else
		echo a:cmd . " is a  [" . s:cmd_type . "]"
	endif

	"restore the iskeyword.
	:let &iskeyword = a:old_isk

endfunction

function! CompletePaths(findstart, base)
	:if a:findstart
		"locate start of the word
		:let line = getline('.')
		:let start = col('.')
		" while start not a valid command character
		:while start > 0 && line[start -1 ] =~ '\a\|\.\|_\|-'
		" decrement it
		:	let start -= 1
		:endwhile
		" and return it.
		:return start
	:else
		" generate the actual completions.
		:let res = []
		:for cmd in system("bash -c 'type -Pa " . shellescape(a:base) . "'")
		:	call add(res, cmd)
		:endfor
		:return res
	:endif
endfunction
set completefunc=CompletePaths


