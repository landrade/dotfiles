"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  " Run shell script if exist on custom select language

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'benekastah/neomake' "Replacement for syntastic
Plug 'kien/ctrlp.vim'
Plug 'raimondi/delimitmate'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'Yggdroot/indentLine'
Plug 'duff/vim-trailing-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'vim-airline/vim-airline' " fancy statusline
Plug 'vim-airline/vim-airline-themes' " themes for vim-airline

"Plug 'davidhalter/jedi-vim'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'

Plug 'altercation/vim-colors-solarized'

call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"

let g:python_host_prog='/usr/local/bin/python'
let g:python3_host_prog = '/Users/leonardo.andrade/.pyenv/versions/neovim/bin/python'

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd

""  detect when a file is changed
set autoread

" faster redrawing
"set ttyfast

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
let g:solarized_termtrans=1

set ruler
set relativenumber
set number

set mousemodel=popup
set t_Co=256

" IndentLine
set autoindent " automatically set indent of new line


"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" Deoplete
let g:deoplete#enable_at_startup = 1

"" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
set grepprg=ag\ --nogroup\ --nocolor
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

noremap <leader>b :CtrlPBuffer<CR>
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

"" neomake
let g:neomake_python_enabled_makers = ['flake8', 'pep8']
" E501 is line length of 80 characters
let g:neomake_python_flake8_maker = { 'args': ['--ignore=E501'], }
let g:neomake_python_pep8_maker = { 'args': ['--max-line-length=105'], }

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:NERDTreeWinSize = 50
let NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeTabsToggle<CR>

"" airline configurations
let g:airline_powerline_fonts=1
"let g:airline_left_sep=''
"let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1 " enable airline tabline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 2 " only show tabline if tabs are being used (more than 1 tab open)
let g:airline#extensions#tabline#show_buffers = 1 " do not show open buffers in tabline
let g:airline#extensions#tabline#show_splits = 0
let g:airline_theme='solarized'

"" Tagbar
nmap <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1


"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

autocmd! BufWritePost * Neomake

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Tabs
"nnoremap <Tab> gt
"nnoremap <S-Tab> gT
"nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Copy/Paste/Cut
set clipboard=unnamed,unnamedplus

"" Buffers nav
noremap <leader>, :bp<CR>
noremap <leader>. :bn<CR>
noremap <leader>w :bd<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4 smartindent
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" vim-go
augroup FileType go
  au!
  au FileType go nmap gd <Plug>(go-def)
  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)

  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)

  au FileType go nmap <Leader>gi <Plug>(go-info)

  au FileType go nmap <leader>gr <Plug>(go-run)
  au FileType go nmap <leader>rb <Plug>(go-build)
  au FileType go nmap <leader>gt <Plug>(go-test)
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_types = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  let g:go_fmt_command = "goimports"

augroup END

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4 smartindent
augroup END

augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
augroup END

"*****************************************************************************
"" Convenience variables
"*****************************************************************************
