map <F7> <Esc>:% w ! bash<CR>
map <F8> <Esc>:% w ! bash -x<CR>
inoremap \cl <ESC>I# 
nnoremap \cl I# <ESC>

" select for loop motion
vnoremap <silent> <leader>af :<c-u> call HighlightLoop(v:count1, "for", "a")<cr>
vnoremap <silent> <leader>aw :<c-u> call HighlightLoop(v:count1, "while", "a")<cr>
vnoremap <silent> <leader>au :<c-u> call HighlightLoop(v:count1, "until", "a")<cr>
                                  
vnoremap <silent> <leader>if :<c-u> call HighlightLoop(v:count1, "for", "i")<cr>
vnoremap <silent> <leader>iw :<c-u> call HighlightLoop(v:count1, "while", "i")<cr>
vnoremap <silent> <leader>iu :<c-u> call HighlightLoop(v:count1, "until", "i")<cr>

onoremap <leader>af v<leader>af
onoremap <leader>aw v<leader>aw
onoremap <leader>au v<leader>au

onoremap <leader>if v<leader>if
onoremap <leader>iw v<leader>iw
onoremap <leader>iu v<leader>iu

:function! HighlightLoop(cnt,loop_type, select_lvl)
    let l:cursor_start=getpos('.')
    let l:s_lnum = line('.')
    let l:looplvl = a:cnt -1

    let l:oldic = &ignorecase
    let l:oldsc = &smartcase
    let l:oldmagic = &magic
    let l:oldww = &whichwrap

    let &ignorecase = 0
    let &smartcase = 0
    let &magic = 0
    let &whichwrap = "h"

    "while loop bleow does not cope if cursor is on the end done
    if expand("<cword>") ==# 'done'
        let l:looplvl += -1
    endif

    while l:looplvl > 0 || match(getline(l:s_lnum), '\<' . a:loop_type . '\>') == -1 

        let l:mstr = matchstr(getline(l:s_lnum), '\<\(while\|done\|for\|until\)\>')

        if l:mstr == "done"
            let l:looplvl += 1
        elseif strlen(l:mstr) > 0
            if l:looplvl > 0
                let l:looplvl -= 1
            endif
        endif

        let l:s_lnum -= 1
        
        "need to manually bail if we hit the first line of the file witout matching
        if l:s_lnum == 0
            call setpos('.', l:cursor_start)
            return 1
        endif
    endwhile

    if a:select_lvl == "a"
        " match returns the colum immediately before the match.
        let l:s_cnum = match(getline(l:s_lnum), '\<' . a:loop_type . '\>') + 1
        let l:select_done = "e"
    elseif a:select_lvl == "i"
        call setpos('.', [ 0, l:s_lnum, 1, 0 ])
        let [ l:s_lnum, l:s_cnum ] = searchpos('\(\<\(while\|for\|until\)\>\(\_.\)\{-}\)\<do\>\zs\_.', 'We') 
        "unselect the 1st d of done
        let l:select_done = "h"
    endif

    :call setpos('.', [ 0, l:s_lnum, l:s_cnum, 0 ])
    :call setpos("'<", [ 0, l:s_lnum, l:s_cnum, 0 ])

    let l:end   = searchpairpos('\<\(while\|for\|until\)\>', '', '\<done\>', "W")
    call setpos("'>", [ 0, l:end[0], l:end[1], 0 ] )
    execute "normal! gv" . l:select_done

    let &ignorecase = l:oldic
    let &smartcase = l:oldsc
    let &magic = l:oldmagic
    let &whichwrap = l:oldww
    
:endfunction

