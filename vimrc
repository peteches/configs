"ensure not compatible
set nocompatible

"required for Vundle.
"Will be reenabled later
filetype off

"set up env for vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"let vundle manage itself
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
"" UltiSnip stuff
Bundle 'SirVer/ultisnips'
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/UltiSnips-2.2/UltiSnips/"
let g:UltiSnipsExpandTrigger= '<tab>'
let g:UltiSnipsListSnippets = '<C-L>'
let g:UltiSnipsJumpForwardTrigger= '<C-J>'
let g:UltiSnipsJumpBackwardTrigger= '<C-K>'
nmap <LEADER>es :UltiSnipsEdit<CR>

Bundle 'klen/python-mode'
" will add settings to this later

"" powerline stuff
Bundle 'Lokaltog/powerline'
set rtp+=$HOME/.vim/bundle/powerline
let g:powerline_config_path = expand("$HOME/.config/powerline")

" Nerdtree Stuff
Bundle 'scrooloose/nerdtree'
let NERDTreeQuitOnOpen=1

" Tabularize
Bundle 'godlygeek/tabular'

" reset the filetype stuff.
filetype plugin indent on


set autoindent
set cmdheight=2
set confirm
set expandtab
set foldclose=all
set foldcolumn=2
set foldopen=hor,insert,jump,mark,search,tag,undo
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<,eol:$,nbsp:-
set nohls
set noshowmode
set notimeout ttimeout ttimeoutlen=200
set number
set pastetoggle=<F2>
set ruler
set scrolloff=30
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set softtabstop=4
set tabpagemax=100
set textwidth=1000
set tildeop
set title
set ts=4
set viminfo='1000,f1,:100,/100,%,!
set visualbell
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
