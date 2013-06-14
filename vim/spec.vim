map <F5> <ESC>/%changelog<CR>:r! date "+* \%a \%b \%d \%Y - Pete McCabe <pete.mccabe@frogtrade.com>"<CR>:/^Version:[[:blank:]]*/,//+1 yank<CR>:put<CR>k:.,+1!awk '{print $NF}'<CR>Jr-0i- <ESC>o- <CR><ESC>kA
noremap <F6> <Esc>:call ValidateSpec()<CR>
noremap <F7> <Esc>:call SvnDiff()<CR>


let g:rpmlint_cmd = "/usr/bin/frog-rpmlint.py"
let g:diff_cmd = "/usr/bin/svn diff"

if ! exists("g:diff_window_exists")
	let g:diff_window_exists = 0
endif

if ! exists("g:rpmlint_window_exists")
	let g:rpmlint_window_exists = 0
endif


function! SvnDiff()

	if g:diff_window_exists == 1
		execute ":" . bufwinnr("__diff__") . " wincmd w"
		execute ":close"
		let g:diff_window_exists = 0
	else
		" get output of diff
		let diff = system(g:diff_cmd . " " . bufname("%") . " 2>&2" )

		bel vsplit __diff__
		let g:diff_window_exists=1

		normal! ggdG

		setlocal buftype=nofile
		setlocal bufhidden=hide
		setlocal noswapfile
		setlocal filetype=diff

		call append(0, split(diff, '\v\n'))
		execute ":wincmd h"
	endif


endfunc

function! ValidateSpec()

	if g:rpmlint_window_exists == 1
		execute ":" . bufwinnr("__rpmlint__") . " wincmd w"
		execute ":close"
		let g:rpmlint_window_exists = 0
	else
		"get output of rpmlint
		let lint = system(g:rpmlint_cmd . " " . bufname("%") . " 2>&1" )

		bel vsplit __rpmlint__
		let g:rpmlint_window_exists=1

		normal! ggdG

		setlocal buftype=nofile
		setlocal bufhidden=hide
		setlocal noswapfile

		call append(0, split(lint, '\v\n'))

		execute ":wincmd h"
	endif

endfunc
