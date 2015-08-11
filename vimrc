
set nocompatible

" colour setup
set t_Co=256
"colorscheme zellner
"colorscheme delek
"colorscheme emacs
syntax on

" folding set up
highlight Folded     ctermbg=0
" highlight FoldColumn ctermbg=0
" set foldcolumn=1

let mapleader = "," " make comma the leader. Easier to get to on the MB than backslash

set expandtab                  "\
set softtabstop=2              " ) make tabs two spaces
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
set gdefault                   " make all search-and-replace operations global
set cpoptions=B$               " show existing content when changing text, and show a '$'
                               " at the end of the content that is to be changed.
set splitright                 " put new split windows on the right or below the current
set splitbelow                 " one, rather than to the left or above
set modeline                   " take note of modelines in files

" setup the GUI
" set guifont=-misc-monospace-medium-r-semicondensed-*-*-110-*-*-c-*-koi8-r
set guifont=Inconsolata-dz\ for\ Powerline:h11
set guioptions=aegirL
" turn off the menubar
nmap <silent> <F2> :set go-=m<CR>
" turn on  the menubar
nmap <silent> <F3> :set go+=m<CR>
set guicursor+=a:blinkon0      " turn off the blinking cursor in the GUI

" make matching parens readable !
hi MatchParen ctermfg=5

" general key mappings

" map control + movement keys to 'switch to split'
" map <C-H> <C-W>h
" map <C-J> <C-W>j
" map <C-K> <C-W>k
" map <C-L> <C-W>l

" duplicate the current line and comment the original
map <leader>du yypkgccj

" save currentbuffer
nmap     <leader>s      :w<CR>
" save all buffers
nmap     <leader>sa     :wa<CR>
" toggle highlighting of search terms
nnoremap  <silent> <C-n> :se invhlsearch<CR>
" toggle line numbers
nnoremap <leader>nn     :set number!<CR>
" toggle relative line numbers
nnoremap <leader>nr     :set relativenumber!<CR>
" toggle buffer read-only
nnoremap <leader>ro     :set readonly!<CR>
"\toggle mouse on and off
nmap     <leader>mo     :set mouse=a<CR>
"/
nmap     <leader>mO     :set mouse=<CR>
" noremap n nzz                                   "\make "n" and "N" centre search term
" noremap N Nzz                                   "/
" map "ii" to escape
inoremap ii <ESC>

nmap <leader>nw :set wrap!<CR>

" abbreviations
iab __HOME__  /nfs/users/nfs_j/jt6
iab strictl   strict;
iab warningsl warnings;

" subvert the "make" command to compile perl
autocmd filetype perl set makeprg=$VIMRUNTIME/tools/efm_perl.pl\ -c\ %\ $*
autocmd filetype perl set errorformat=%f:%l:%m
autocmd filetype perl set autowrite

" set perl tests to be perl files
autocmd BufNewFile,BufRead *.t setf perl

" for TT2 syntax highlighting
au BufNewFile,BufRead *.tt setf tt2html
" au BufNewFile,BufRead *.tt
" \ if (   getline(1) . getline(2) . getline(3) =~ '<\chtml'
" \     && getline(1) . getline(2) . getline(3) !~ '<[%?]' )
" \     || getline(1) =~ '<!DOCTYPE HTML'
" \   setf tt2html
" \ else
" \   setf tt2
" \ endif

let b:tt2_syn_tags = '\[% %] <!-- -->'

" set a mapping to toggle between the two previously used tabs
let g:lasttab = 1
nmap <silent> tt :exe "tabn ".g:lasttab<cr>
au TabLeave * :let g:lasttab = tabpagenr()

" toggle "set paste"
set pastetoggle=<Leader>pp

" Perl Tidy
" use perltidy to clean up perl code (hit "=")
autocmd Filetype perl :set equalprg=perltidy

" define :Tidy command to run perltidy on visual selection || entire buffer"
command -range=% -nargs=* Tidy <line1>,<line2>!perltidy
" command -range=% -nargs=* Tidy <line1>,<line2>!perltidy -l=132 -ci=2 -i=2 -nsfs -bar -bbb -bbs -bbc -anl -otr

" run :Tidy on entire buffer and return cursor to (approximate) original position"
fun DoTidy()
    let Pos = line2byte( line( "." ) )
    :Tidy
    exe "goto " . Pos
endfun

"shortcut for normal mode to run on entire buffer then return to current line"
au Filetype perl nmap <leader>pt :call DoTidy()<CR>

"shortcut for visual mode to run on the the current visual selection"
au Filetype perl vmap <leader>pt :Tidy<CR>

"-------------------------------------------------------------------------------
"- plugin configurations -------------------------------------------------------
"-------------------------------------------------------------------------------

" runtime macros/matchit.vim

filetype off

set rtp+=~/.vim/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

"-------------------------------------------------------------------------------
" NERDTree

Plugin 'The-NERD-tree'
Plugin 'NERD_Tree-and-ack'
"
let NERDTreeQuitOnOpen=1
let NERDTreeHighlightCursorLine=1
let NERDTreeChDirMode=2
"
" open NERDTree
nmap <silent> <leader>nt :NERDTreeToggle<CR>

"-------------------------------------------------------------------------------
" VCSCommand

Plugin 'vcscommand.vim'

" reset the command prefix
let VCSCommandMapPrefix="<Leader>v"

"-------------------------------------------------------------------------------
" LustyJuggler and LustyExplorer

Plugin 'LustyExplorer'
Plugin 'LustyJuggler'

" add an extra mapping for LustyExplorer
map <leader>lh :LustyFilesystemExplorerFromHere<CR>

"-------------------------------------------------------------------------------
" Ack

" Plugin "ack.vim"
"
" noremap <LocalLeader># "ayiw:Ack <C-r>a<CR>
" vnoremap <LocalLeader># "ay:Ack <C-r>a<CR>

"-------------------------------------------------------------------------------
" Taglist
"
" Plugin "taglist.vim"
"
" let Tlist_perl_settings = 'perl;c:constant;l:label;p:package;s:subroutine;a:attribute'
" let Tlist_GainFocus_On_ToggleOpen = 1
" let Tlist_Close_On_Select = 1
" let Tlist_Show_One_File = 1
"
" nnoremap <leader>tl :TlistToggle<CR>

"-------------------------------------------------------------------------------
" Unimpaired

Plugin 'unimpaired.vim'

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

"-------------------------------------------------------------------------------
" solarized

Plugin 'altercation/vim-colors-solarized'
let g:solarized_termtrans=1
set background=dark
colorscheme solarized

"-------------------------------------------------------------------------------
" Command-T

Plugin 'wincent/Command-T'

nnoremap <C-t> :CommandT<CR>

"-------------------------------------------------------------------------------
" airline

Plugin 'bling/vim-airline'
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline#extensions#tmuxline#enabled = 1

"-------------------------------------------------------------------------------
" vim-search-pulse

" not quite mature enough yet...
" Plugin 'https://github.com/inside/vim-search-pulse.git'
" let g:vim_search_pulse_mode = 'pattern'
" let g:vim_search_pulse_duration = 400
" nmap n n<Plug>PulseCursorLine
" nmap N N<Plug>PulseCursorLine
" nmap * *<Plug>PulseCursorLine
" nmap # #<Plug>PulseCursorLine
" " Pulses cursor line on first match
" " " when doing search with / or ?
" cmap <enter> <Plug>PulseFirst

"-------------------------------------------------------------------------------
" everything else...

Plugin 'Align'
Plugin 'bufexplorer.zip'
Plugin 'repeat.vim'
Plugin 'sessionman.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'surround.vim'
Plugin 'vim-perl/vim-perl'
Plugin 'EasyMotion'
Plugin 'camelcasemotion'
Plugin 'tComment'
Plugin 'IndexedSearch'
Plugin 'SirVer/ultisnips'
Plugin 'ervandew/supertab'
Plugin 'matchit.zip'
Plugin 'christoomey/vim-tmux-navigator'

"-------------------------------------------------------------------------------
" all bundles must be added before here

call vundle#end()
filetype plugin indent on

"-------------------------------------------------------------------------------
" host-specific setup

" let hostfile=expand('$HOME/.vim/vimrc-'.hostname())
" if filereadable(hostfile)
"   exe 'source '.hostfile
" endif

