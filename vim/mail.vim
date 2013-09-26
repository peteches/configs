set textwidth=79
set nolist

execute "normal! G"
call searchpos('^-- $', 'Wbc')
execute "normal! O\<esc>O"
