" vim: foldmethod=marker:foldlevel=0

" Pathogen {{{
" call pathogen for enabling plugins
execute pathogen#infect()

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
" mappings:
" map  - keymap for normal, visual, select, oper.pending mode
" map! - keymap for insert and command-line mode 
" nmap - Display normal mode maps
" imap - Display insert mode maps
" vmap - Display visual and select mode maps
" smap - Display select mode maps
" xmap - Display visual mode maps
" cmap - Display command-line mode maps
" omap - Display operator pending mode maps
" shortcuts for switching tabs. Now use alt+N or cmd+N for switching
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
map <M-9> 9gt
map <M-0> :tablast<CR>
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

" allow the mouse to do selections
" to do 'regular' mouse selection, use ctrl+selection so you can copy, for example
set mouse=a

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

" Toggle the Tagbar (plugin: http://majutsushi.github.io/tagbar/)
nmap <F8> :TagbarToggle<CR>

"}}}

" ControlP plugin{{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" ignor files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }

" set the starting directory
" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr _darcs
" 'a' - like c, but only if the current working directory outside of CtrlP is not a direct ancestor of the directory of the current file.
" 0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'ra'
"}}}

" NERDTree {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" C-n or :NERDTreeToggle         # opens NERDTree

"""""""""""""""""""
" O P E N I N G 
" m                              # opens menu mode for creating/deleting files, 'Ctrl-c' exits out of this mode
" i                              # opens file with horizontal split
" s                              # opens file in vertical split
" o or <enter>                   # opens selected file
" t                              # opens file in new tab

"""""""""""""""""""
" B O O K M A R K S 
" B                              # shows bookmarks
" :Bookmark <name>               # creates bookmark for selected tree branch
" D                              # deletes selected bookmark

" :NERDTreeFind                  # finds current file in tree
" q                              # closes NERDTree
" Ctrl-w-w                       # jump cursor to next viewport including the one for NERDTree
" gt and gT                      # switches between tabs

" Toggle Nerdtree with ctrl+N
nmap <c-n> :NERDTreeToggle<CR>

"" Optional, to show special NERDTree browser characters properly (e.g. on remote linux system)
let g:NERDTreeDirArrows=0

"" Show bookmarks by default
let NERDTreeShowBookmarks=1
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

" TMUX {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" source: http://manuals.bioinformatics.ucr.edu/home/programming-in-r/vim-r
" sample settings for vim-r-plugin and screen.vim
" Installation 
"       - Place plugin file under ~/.vim/
"       - To activate help, type in vim :helptags ~/.vim/doc
"       - Place the following vim conf lines in .vimrc
" Usage
"       - Read intro/help in vim with :h vim-r-plugin or :h screen.txt
"       - To initialize vim/R session, start screen/tmux, open some *.R file in vim and then hit F2 key
"       - Object/omni completion command CTRL-X CTRL-O
"       - To update object list for omni completion, run :RUpdateObjList
" My favorite Vim/R window arrangement 
"	tmux attach
"	Open *.R file in Vim and hit F2 to open R
"	Go to R pane and create another pane with C-a %
"	Open second R session in new pane
"	Go to vim pane and open a new viewport with :split *.R
" Useful tmux commands
"       tmux new -s <myname>       start new session with a specific name
"	tmux ls (C-a-s)            list tmux session
"       tmux attach -t <id>        attach to specific session  
"       tmux kill-session -t <id>  kill specific session
" 	C-a-: kill-session         kill a session
" 	C-a %                      split pane vertically
"       C-a "                      split pane horizontally
" 	C-a-o                      jump cursor to next pane
"	C-a C-o                    swap panes
" 	C-a-: resize-pane -L 10    resizes pane by 10 to left (L R U D)
" Corresponding Vim commands
" 	:split or :vsplit      split viewport
" 	C-w-w                  jump cursor to next pane-
" 	C-w-r                  swap viewports
" 	C-w C-++               resize viewports to equal split
" 	C-w 10+                increase size of current pane by value

" To open R in terminal rather than RGui (only necessary on OS X)
" let vimrplugin_applescript = 0
" let vimrplugin_screenplugin = 0
" For tmux support
let g:ScreenImpl = 'Tmux'
let vimrplugin_screenvsplit = 1 " For vertical tmux split
let g:ScreenShellInitialFocus = 'shell' 
" instruct to use your own .screenrc file
let g:vimrplugin_noscreenrc = 1
" For integration of r-plugin with screen.vim
"let g:vimrplugin_screenplugin = 1
" Don't use conque shell if installed
let vimrplugin_conqueplugin = 0
" map the letter 'r' to send visually selected lines to R 
"let g:vimrplugin_map_r = 1
" see R documentation in a Vim buffer
"let vimrplugin_vimpager = "no"
" start R with F2 key
"map <F2> <Plug>RStart 
"imap <F2> <Plug>RStart
"vmap <F2> <Plug>RStart
" send selection to R with space bar
"vmap <Space> <Plug>RDSendSelection 
" send line to R with space bar
"nmap <Space> <Plug>RDSendLine

" Remove the Background Color Eraser (http://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux)
set t_ut=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"}}}

" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" ,l       : list buffers
" ,b ,f ,g : go back/forward/last-used
" ,1 ,2 ,3 : go to buffer 1/2/3 etc
nnoremap <Leader>l :ls<CR>:buffer<space>
nnoremap <Leader>p :bp<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
" It's useful to show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" Set the phpunit command for CakePHP
let g:phpunit_cmd = "~/Developer/socsoc/app/Console/cake test app "

" Let PHPUnitQf use the callback function
let g:phpunit_callback = "CakePHPTestCallback"

function! CakePHPTestCallback(args)
    " Trim white space
    let l:args = substitute(a:args, '^\s*\(.\{-}\)\s*$', '\1', '')

    " If no arguments are passed to :Test
    if len(l:args) is 0
        let l:file = expand('%')
        if l:file =~ "^app/Test/Case.*"
            " If the current file is a unit test
            let l:args = substitute(l:file,'^\(app/\)\=\(Test/\)\=\(Case/\)\=\(.\{-}\)Test\.php$','\4','')
        else
            " Otherwise try and run the test for this file
            let l:args = substitute(l:file,'^app/\(.\{-}\)\.php$','\1','')
        endif
    endif
    return l:args
endfunction
