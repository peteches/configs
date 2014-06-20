onoremap ab :<c-u>execute "normal! j? do$?\rV/end/\r"<cr>
onoremap ib :<c-u>execute "normal! j? do$?\rjV/end/\rk"<cr>
call MakeTabsConsistent('r', 2)
autocmd BufWritePre <buffer> call MakeTabsConsistent('w', 2)
autocmd BufWritePost <buffer> call MakeTabsConsistent('r', 2)
