set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
"Plugin 'Conque-GDB'
Plugin 'Chiel92/vim-autoformat'
Plugin 'flazz/vim-colorschemes'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'shougo/neocomplcache.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Yggdroot/indentLine'
Plugin 'sheerun/vim-polyglot'
Plugin 'ryanoasis/vim-devicons'
Plugin 'luochen1990/rainbow'
Plugin 'joeytwiddle/sexy_scroller.vim'


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
set number
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set mouse=a
set textwidth=80
set cursorline
set background=dark
colorscheme Benokai
let g:airline_theme='badwolf'

if has("syntax")
    syntax on
    filetype on
    au BufNewFile,BufRead *.jq set filetype=javascript
endif


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

set t_Co=256
if (has("termguicolors"))
    set termguicolors
endif

let g:NERDTreeWinPos = "left"
let g:NERDTreeWinWidth = 25
let g:nerdtree_tabs_open_on_console_startup = 0 
let g:tagbar_left = 0
let g:tagbar_width = 25

"Syntastic things
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = "X>"
let g:syntastic_warning_symbol = "!>"
let g:syntastic_auto_loc_list = 1
let g:syntastic_style_error_symbol = 'S>'
let g:syntastic_style_warning_symbol = 'S>'
let g:syntastic_auto_jump = 0
let g:syntastic_loc_list_height = 5

"highlight link SyntasticErrorSign SignColumn
"highlight link SyntasticWarningSign SignColumn
hi SpellBad ctermfg=015 ctermbg=160
hi SpellCap ctermfg=015 ctermbg=208

" Highlight redundant whitespaces and tabs.
highlight RedundantSpaces ctermbg=red
match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

silent! map <F2> :Autoformat<CR>
silent! map <F5> :NERDTreeToggle<CR>
silent! map <F6> :TagbarToggle<CR>

"indent Line
let g:indentLine_enabled = 1
let g:indentLine_setColors = 1
let g:indentLine_color_term = 0
let g:indentLine_char = '¦'



"neocomplcache things
let	g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 2
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"Raininbow parenthesis
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
            \   'ctermfgs': [28, 126, 33, 202],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \}


