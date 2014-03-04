" vim: foldmethod=marker:foldlevel=0

" Pathogen {{{
" call pathogen for enabling plugins
call pathogen#infect()

"}}}

" VIM Airline {{{

" patch je fonts. Instructies van: https://powerline.readthedocs.org/en/latest/fontpatching.html
" $ sudo apt-get install python-fontforge

" Copy the font file into ~/.fonts (or another X font directory):
" $ cp "MyFontFile for Powerline.otf" ~/.fonts

" Update your font cache:
" If you're using vim in a terminal you may need to close all
" open terminal windows after updating the font cache.
" $ fc-cache -vf ~/.fonts

" use 256 colors
set t_Co=256

" use unicode symbols
let g:Powerline_symbols = "fancy"

"}}}

" Tabs {{{
" shortcuts for switching tabs. Now use cmd+N for switching
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>
"}}}

" Syntax {{{

" enable syntax highlighting
syntax on
syntax enable

" show linenumbers
set number

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set tabstop=4   " number of visual spaces per TAB
" set softtabstop=2 " the number of spaces that is inserted when you hit <TAB>
" set expandtab   " use spaces instead of tabs (use for Python!)

"
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

"
" Show partial commands in the last line of the screen
"set showcmd

"
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
" filetype indent plugin on
"

"}}}

" Search {{{

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

"}}}

" Miscellaneous {{{
" Allow vim settings in the header-comment
set modeline

"
" Always display the status line, even if only one window is displayed
set laststatus=2

"
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

"
" Use visual bell instead of beeping when doing something wrong
set visualbell

"
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

"
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

"
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" colorscheme badwolf
colorscheme badwolf

" show command in bottom bar
set showcmd

" highlight current line
set cursorline

" visual autocomplete for command menu
set wildmenu

" leader is comma
let mapleader=","

" Easy shortcuts for editing the .vimrc and .bashrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>       " edit the vimrc
nnoremap <leader>eb :vsp ~/.bashrc<CR>      " edit bashrc
nnoremap <leader>sv :source $MYVIMRC<CR>    " execute the commands in .vimrc

"}}}

" SESSIONS {{{
" save session
nnoremap <leader>s :mksession<CR>
"}}}

" Folding {{{

" Enable folding, show all folds
set foldenable

" Open most folds by default
set foldlevelstart=10

" Folds can be nested. Setting a max on the number of
" folds guards against too many folds
set foldnestmax=10

" fold based on indent level. Other acceptable values are marker,
" manual, expr, syntax, diff
set foldmethod=indent

" Use <space> for opening/closing folds
nnoremap <space> za

" each time you close a file, its fold state will be saved and reloaded
" when you reopen the file in Vim
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" }}}
