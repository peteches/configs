"call pathogen to organise plugins
call pathogen#infect()
filetype plugin indent on

set autoindent
set cmdheight=2
set confirm
set foldcolumn=2
set foldopen=hor,insert,jump,mark,search,tag,undo
set foldclose=all
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<,eol:$,nbsp:-
set nohls
set notimeout ttimeout ttimeoutlen=200
set number
set pastetoggle=<F2>
set ruler
set scrolloff=30
set shiftwidth=4
set showcmd
set showmatch
set noshowmode
set smartcase
"set statusline=[%n]\ %y\ ./%-f%M%R\ %=Col:\ %02c\ (%02v)\ Line:\ %02l\ /\ %02L\ %P
set tabpagemax=100
set textwidth=1000
set tildeop
set title
set ts=4
set viminfo='1000,f1,:100,/100,%,!
set visualbell

"" powerline stuff
set rtp+=$HOME/.vim/bundle/powerline
let g:powerline_config_path = expand("$HOME/.config/powerline")

"" UltiSnip stuff
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/UltiSnips-2.2/UltiSnips/"
let g:UltiSnipsExpandTrigger= '<tab>'
let g:UltiSnipsListSnippets = '<C-L>'
let g:UltiSnipsJumpForwardTrigger= '<C-J>'
let g:UltiSnipsJumpBackwardTrigger= '<C-K>'
nmap <LEADER>es :UltiSnipsEdit<CR>

"" Rainbow parenthesis
let g:niji_match_all_filetypes = 1
let g:niji_dark_colours = [['brown', 'RoyalBlue3'],
                            \ ['Darkblue', 'SeaGreen3'],
                            \ ['darkgray', 'DarkOrchid3'],
                            \ ['darkgreen', 'firebrick3'],
                            \ ['darkcyan', 'RoyalBlue3']]
let g:niji_light_colours = g:niji_dark_colours

"" Tagbar stuff
let g:tagbar_ctags_bin = "/usr/bin/ctags"
let g:tagbar_compact = 1
let g:tagbar_indent = 2

let NERDTreeQuitOnOpen=1
let g:pydiction_location='~/.vim/bundle/pydiction-1.2/complete-dict'

abbr slef self
abbr resutl result
abbr fro for
abbr fiel file
abbr teh the
abbr fsp /usr/lib/frogshell/
map Y y$
" <F1> help
" <F2> pasteToggle
map <F3> <ESC>:set nu! list! foldenable!<CR>
map <F4> <ESC>:NERDTreeToggle<CR>
map <F5> <ESC>/\(done\)\@<! TODO<CR>
map <F9> <Esc>:%w ! diff -u --label="saved" % --label="buffer" - <CR>

imap <LEADER>.. <LEADER>2, 
imap <LEADER>' <ESC>viWS'Ea
imap <LEADER>2 <ESC>viWS"Ea
imap <LEADER>w' <ESC>viwS'Ea
imap <LEADER>w2 <ESC>viwS"Ea
nmap <LEADER>+x <ESC>:!chmod +x %<CR>

nmap <LEADER>er :vsplit ~/.vim/vimrc<CR>
nmap <LEADER>sr :so ~/.vim/vimrc<CR>
inoremap <LEADER>gf <ESC><C-W>gf
nnoremap gf <C-W>gf

" window mappings
map <C-LEFT> <c-w>h
map <C-RIGHT> <c-w>l
map <C-DOWN> <c-w>j
map <C-UP> <c-w>k
imap <C-LEFT> <ESC><c-w>h
imap <C-RIGHT> <ESC><c-w>l
imap <C-DOWN> <ESC><c-w>j
imap <C-UP> <ESC><c-w>k

" quick tab movements
map <S-LEFT> gT
map <S-RIGHT> gt
imap <S-LEFT> <ESC>gT
imap <S-RIGHT> <ESC>gt

"file completion
imap <C-f> <C-x><C-f>

cmap W w
cmap Q q

if has("autocmd")
autocmd BufNewFile * call LoadTemplate()
autocmd FileType c source ~/.vim/c.vim
autocmd FileType cpp source ~/.vim/cpp.vim
autocmd FileType spec source ~/.vim/spec.vim
augroup SHELL
	autocmd FileType sh source ~/.vim/shell.vim
augroup END
augroup PERL
	autocmd FileType *.p[lm] source ~/.vim/perl.vim
augroup END
endif

colorscheme peteches

function! LoadTemplate()
	silent! 0r ~/.vim/skel/template.%:e
	"Highlight %VAR% placeholders with the TODO colour group
	syn match Todo "%\u\+%" containedIn=ALL
endfunction
