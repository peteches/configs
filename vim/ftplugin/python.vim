filetype plugin indent on

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

augroup SYNTAX
	autocmd!
	autocmd FileWritePre,FileAppendPre,FilterWritePre,BufWritePre * Pep8
augroup END
