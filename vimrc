" pathogen plugin for managing runtimepath
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocompatible
syntax on
colorscheme Tomorrow-Night-Eighties
filetype plugin on
set ai
set tabstop=2 shiftwidth=2 expandtab

" don't highlight matching parentheses/brackets
let loaded_matchparen=1

" display relative line numbers
set relativenumber

" with vsplit, have new window on the right
set splitright

" with split, have new window on bottom
set splitbelow

" reaching for escape is a pain, and I don't type kj much in vim
inoremap kj <Esc>
cnoremap kj <C-c>
xnoremap kj <C-c>
snoremap kj <Esc>

" 2 <C-g> is more helpful than <C-g>
"noremap <C-g> 2<C-g>
set laststatus=2
let g:airline_theme='dark'

" resize vsplits on window resize
" taken from http://vimbits.com/bits/268
au VimResized * exe "normal! \<c-w>="

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
" taken from http://vimbits.com/bits/244
if isdirectory($HOME . '/.vim/swap') == 0
:silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" spellcheck Git commit messages
autocmd BufRead COMMIT_EDITMSG setlocal spell!

" for commit messages, open diff (between current and HEAD) in split window
autocmd BufRead COMMIT_EDITMSG rightb vert new | set buftype=nofile | set bufhidden=hide | setlocal noswapfile | read !git diff --cached

" mark todo lines as done (with current date)
let @d=':s/^/x =strftime("%Y-%m-%d") /'

let mapleader = ";"
let maplocalleader = ","

set wildignore+=.git,*.class,*/generated-code/*,*/target/*

" a search like '/' but escapes special characters
command! -nargs=1 SS let @/ = '\V'.escape(<q-args>, '/\')|normal! /<C-R>/<CR>

" search for tags files in reasonable places
set tags=./.tags,.tags,./tags,tags

" NERD tree
" shortcut to open NERD tree
map <leader>n :NERDTreeToggle<CR>
" Close vim if the only window left is a NERD tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q
let NERDTreeShowLineNumbers=1

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" make ctrl-p use tags by default
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>pt :CtrlPTag<CR>
" let ctrl-p searches use ctags, etc
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'bookmarkdir']

" ack.vim
nnoremap <leader>a :Ack! 
nnoremap <leader>as :Ack! --type scala 
nnoremap <leader>afs yiw:Ack! --type scala <C-r>"<CR>

" open a tag in a vertical split
nnoremap <leader>v :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" undo file changes from fugitive commit view
autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
