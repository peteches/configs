map <F7> <Esc>:% w ! bash<CR>
map <F8> <Esc>:% w ! bash -x<CR>
inoremap \ds display_status
inoremap \err \|\| error=$?
inoremap \cl <ESC>I# 
nnoremap \cl I# <ESC>
