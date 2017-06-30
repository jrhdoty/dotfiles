set nocompatible

filetype off

" Check to see if vimrc is being loaded at google.
let s:at_google=filereadable(expand('~/.at_google'))

"======================"
" Vundle configuration "
"======================"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Code search
Plugin 'ctrlpvim/ctrlp.vim'

" Directory tree
Plugin 'scrooloose/nerdtree'

" Tern for vim
Plugin 'ternjs/tern_for_vim'

" Git plugin
Plugin 'tpope/vim-fugitive'

" Code snippets
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Color scheme
Plugin 'NLKNguyen/papercolor-theme'

if !s:at_google
    Plugin 'Valloric/YouCompleteMe'
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"==================================="
" Load and Configure Google Plugins "
"==================================="


if s:at_google
    " Load the default google configuration
    source /usr/share/vim/google/google.vim

    " Allow autoformatting of build files
    Glug codefmt
    Glug codefmt-google
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType java AutoFormatBuffer gtimporter
    noremap <unique> <leader>j :GtImporter<CR>

    " \pf - open a window showing the files that have been changed in this CL.
    Glug piper plugin[mappings]
    " \r - open a window showing files related to this one (BUILD, test files, etc.)
    " \rb - open the BUILD file
    " \rt and \rc to flip between source and test file
    Glug relatedfiles plugin[mappings]

    " Code completion
    Glug youcompleteme-google
    " Turn off C++ support because we don't need it
    let g:ycm_filetype_blacklist = {'cpp': 1, 'c': 1}

    " Code snippets
    Glug ultisnips-google

    Glug gtimporter
endif


"===================="
" Some basic options "
"===================="

" Enable syntax highlighting
syntax on

" Set the colorscheme
set t_Co=256 " This may or may not be needed.
set background=dark
colorscheme PaperColor

" Size of a hard tabstop
set tabstop=2

" Size of an indent
set shiftwidth=2

set softtabstop=2

" Always uses spaces instead of tab characters
set expandtab

" Treat .ng files as html for highlighting
au BufReadPost *.ng set syntax=html

" Remap jk to escape.
inoremap jk <esc>
inoremap kj <esc>
vno v <esc>

set encoding=utf-8

" Add vertical line at 80 chars
set colorcolumn=80
highlight ColorColumn ctermbg=4

" Add line numbers
set number
:highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

"========================"
" NerdTree Configuration "
"========================"

" Map for opening NerdTree with current file.
nmap ,m :NERDTreeFind<CR>

" Set default window size for nerdtree
let g:NERDTreeWinSize=35

let g:NERDTreeDirArrows=0

"========================"
" Ultisnips Configuration "
"========================"

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
" Turn off the default behavior for c-
set runtimepath+=~/.vim/my-snippets/
let g:BASH_Ctrl_j = 'off'
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" This needs to be the last line in the file
filetype plugin indent on
