call MakeTabsConsistent('r', 2)
autocmd BufWritePre *.js call MakeTabsConsistent('w', 2)
autocmd BufWritePost *.js call MakeTabsConsistent('r', 2)
