filetype plugin indent on

call MakeTabsConsistent('r', 4)
autocmd BufWritePre <buffer> call MakeTabsConsistent('w', 4)
autocmd BufWritePost <buffer> call MakeTabsConsistent('r', 4)

" pymode stuff
let g:pymode_lint_checkers = [  "pylint", "pep8", "mccabe" ]
let g:pymode_lint_ignore = "E501,C0301"
