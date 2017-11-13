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
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'Conque-GDB'
Plugin 'Chiel92/vim-autoformat'
Plugin 'flazz/vim-colorschemes'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Rip-Rip/clang_complete'
Plugin 'Yggdroot/indentLine'
Plugin 'sheerun/vim-polyglot'
Plugin 'ryanoasis/vim-devicons'
Plugin 'luochen1990/rainbow'
Plugin 'joeytwiddle/sexy_scroller.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neoinclude.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'guns/xterm-color-table.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

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
set colorcolumn=81
colorscheme Benokai
let g:airline_theme='atomic'

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


"Ctrlp things
let g:ctrlp_switch_buffer = 1
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_use_caching = 1
"Exclude object files
set wildignore+=*/*.o

"Nerdtree things
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinWidth = 25
let g:nerdtree_tabs_open_on_console_startup = 0

"Nerdcommenter things
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1

"Tagbar things
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
let g:syntastic_java_javac_options = '-Xlint -encoding UTF-8 -classpath ~/algs4.jar'
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'


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


let g:tagbar_autoclose = 0
autocmd FileType * nested :call tagbar#autoopen(0)

"indent Line
let g:indentLine_enabled = 1
let g:indentLine_setColors = 1
let g:indentLine_color_term = 0
let g:indentLine_char = '¦'

"Sexyscroller things
let g:SexyScroller_EasingStyle = 4
let g:SexyScroller_ScrollTime = 100
let g:SexyScroller_CursorTime = 50
let g:SexyScroller_MaxTime = 200


"Gitgutter things
hi GitGutterAdd          ctermbg=2  ctermfg=2" an added line
hi GitGutterChange       ctermbg=3  ctermfg=3" a changed line
hi GitGutterDelete       ctermbg=1  ctermfg=1" at least one removed line
hi GitGutterChangeDelete ctermbg=4  ctermfg=4" a changed line followed by at least one removed line


"neocomplete things
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
imap <C-k>     <Plug>(neosnippet_expand_or_jump)

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^.\t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:]*\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:]*\t]\%(\.\|->\)\|\h\w*::'
set completeopt-=preview


"clang-comlete
let g:clang_library_path = '/usr/lib/rstudio/bin/rsclang/'
let g:clang_snippets = 1
let g:clang_conceal_snippets = 1
let g:clang_snippets_engine='clang_complete'


"neocomplcache things
"let g:neocomplcache_enable_ignore_case = 1
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_auto_completion_start_length = 2
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"Raininbow parenthesis
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
            \   'ctermfgs': [28, 126, 33, 202],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \}


