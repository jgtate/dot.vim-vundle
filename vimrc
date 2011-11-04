
set nocompatible 
filetype plugin on

" colour setup
"colorscheme zellner colorscheme delek
"colorscheme emacs
syntax on

let mapleader = "," " make comma the leader. Easier to get to on the MB than backslash

set expandtab                  "\
set tabstop=2                  " ) make tabs two spaces
set shiftwidth=2               "/
set mouse=a                    "\ turn on mouse control
set ttymouse=xterm2            "/
set incsearch                  " turn on incremental searches
set number                     " show line numbers
set hidden                     " allow switching buffers without saving current buffer
set scrolloff=3                " always keep 3 lines visible when scrolling *
set ignorecase                 " make searches case insensitive
set smartcase                  " overrides ignorecase if uppercase used in search term
set autoindent                 " indent new lines relative to previous one
set smartindent                " change the way indenting works... it's not clear how
set autoread                   " automatically re-read any files that change during editing
set backspace=indent,eol,start " make the backspace key work for indents, work past
                               " the end of a line, and paste the start of an
                               " insertion
set whichwrap+=<,>,h,l         " make left and right movements wrap across lines
set bg=light                   " duh
set gdefault                   " make all search-and-replace operations global
set cpoptions=B$               " show existing content when changing text, and show a '$'
                               " at the end of the content that is to be changed.
set splitright                 " put new split windows on the right rather than the left

" make matching parens readable !
hi MatchParen ctermfg=5

" general key mappings

" save buffer(s)
nmap <leader>s  :w<CR>
nmap <leader>sa :wa<CR>

" toggle highlighting of search terms
noremap <silent> <C-n> :se invhlsearch<CR>

" map control + movement keys to 'switch to split'
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" duplicate the current line and comment the original
map <leader>du yypkgccj

" noremap K :!perldoc <cword> <bar><bar> perldoc -f <cword><cr> " map 'K' to perldoc

" toggle line numbers
nnoremap <leader>nn :set number!<CR>

" toggle buffer read-only
nnoremap <leader>ro :set readonly!<CR>

" toggle mouse
nmap <leader>mo :set mouse=a<CR>
nmap <leader>mO :set mouse=<CR>

" abbreviations
iab __HOME__  /nfs/users/nfs_j/jt6
iab strictl   strict;
iab warningsl warnings;

" switch off syntax highlighting for pdb files
autocmd bufenter *.ent setlocal syntax=
autocmd bufenter *.pdb setlocal syntax=

" subvert the "make" command to compile perl
autocmd filetype perl set makeprg=$VIMRUNTIME/tools/efm_perl.pl\ -c\ %\ $*
autocmd filetype perl set errorformat=%f:%l:%m
autocmd filetype perl set autowrite

" use perltidy to clean up perl code (hit "=")
autocmd Filetype perl :set equalprg=perltidy

" setup the GUI
" set guifont=-misc-monospace-medium-r-semicondensed-*-*-110-*-*-c-*-koi8-r
set guifont=Monospace\ 8
set guioptions=aegirL
nmap <silent> <F2> :set go-=m<CR> " turn off the menubar
nmap <silent> <F3> :set go+=m<CR> " turn on  the menubar

" for TT2 syntax highlighting
" au BufNewFile,BufRead *.tt2
"     \ if ( getline(1) . getline(2) . getline(3) =~ '<\chtml'
"     \           && getline(1) . getline(2) . getline(3) !~ '<[%?]' )
"     \   || getline(1) =~ '<!DOCTYPE HTML' |
"     \   setf tt2html |
"     \ else |
"     \   setf tt2 |
"     \ endif

" set template toolkit template files to be syntax highlighted as html
autocmd bufread *.tt set filetype=tt2html

let b:tt2_syn_tags = '\[% %] <!-- -->' 

" set a mapping to toggle between the two previously used tabs
au TabLeave * :let g:tabno = tabpagenr()
map T :exec 'normal !'.g:tabno.'gt'<cr> 

source $VIMRUNTIME/macros/matchit.vim

"-------------------------------------------------------------------------------
"- plugin configurations -------------------------------------------------------
"-------------------------------------------------------------------------------

" set rtp+=~/.vim/vundle.git
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle "gmarik/vundle"

"-------------------------------------------------------------------------------
" NERDTree
Bundle "The-NERD-tree"
Bundle "NERD_Tree-and-ack"
" 
let NERDTreeQuitOnOpen=1
let NERDTreeHighlightCursorLine=1
let NERDTreeChDirMode=2
" 
" open NERDTree
nmap <silent> <leader>nt :NERDTreeToggle<CR>

"-------------------------------------------------------------------------------
" VCSCommand
Bundle "vcscommand.vim"

" reset the command prefix
let VCSCommandMapPrefix="<Leader>v"

"-------------------------------------------------------------------------------
" LustyJuggler and LustyExplorer
Bundle "LustyExplorer"
Bundle "LustyJuggler"
" 
" " add an extra mapping for LustyExplorer
map <leader>lh :LustyFilesystemExplorerFromHere<CR>

"-------------------------------------------------------------------------------
" tComment
Bundle "tComment"
" 
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

"-------------------------------------------------------------------------------
" Ack
Bundle "ack.vim"
" 
noremap <LocalLeader># "ayiw:Ack <C-r>a<CR>
vnoremap <LocalLeader># "ay:Ack <C-r>a<CR>

"-------------------------------------------------------------------------------
" Taglist
Bundle "taglist.vim"

let Tlist_perl_settings = 'perl;c:constant;l:label;p:package;s:subroutine;a:attribute'
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Show_One_File = 1
 
nnoremap <leader>tl :TlistToggle<CR>

"-------------------------------------------------------------------------------
" Unimpaired

Bundle "unimpaired.vim"

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

"-------------------------------------------------------------------------------
" solarized

" Bundle "https://github.com/altercation/vim-colors-solarized.git"
" set background=dark
" colorscheme solarized

"-------------------------------------------------------------------------------
" BufferGator

Bundle "Buffergator"

let g:buffergator_suppress_keymaps=1
let g:buffergator_display_regime="bufname"

nmap <leader>bg :BuffergatorToggle<CR>
nmap <leader>gg :BuffergatorTabsToggle<CR>

"-------------------------------------------------------------------------------
" everything else...

Bundle "Align"
Bundle "bufexplorer.zip"
Bundle "https://github.com/wincent/Command-T.git"
Bundle "repeat.vim"
Bundle "sessionman.vim"
Bundle "snipMate"
Bundle "https://github.com/ervandew/supertab.git"
Bundle "surround.vim"
Bundle "unimpaired.vim"
Bundle "https://github.com/petdance/vim-perl.git"
Bundle "git://github.com/tsaleh/vim-matchit.git"

"-------------------------------------------------------------------------------
"" host-specific setup

let hostfile=expand('$HOME/.vim/vimrc-'.hostname())
if filereadable(hostfile)
  exe 'source '.hostfile
endif

