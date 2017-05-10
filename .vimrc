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
"Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
"Plugin 'Conque-GDB'
Plugin 'Chiel92/vim-autoformat'
Plugin 'flazz/vim-colorschemes'
Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'shougo/neocomplcache.vim'
"Plugin 'Shougo/deoplete.nvim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Yggdroot/indentLine'
Plugin 'sheerun/vim-polyglot'
Plugin 'ryanoasis/vim-devicons'
Plugin 'luochen1990/rainbow'


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
set guifont=Roboto\ Mono\ for\ Powerline\ 11
set cursorline
set background=dark
colorscheme Benokai
let g:airline_theme='badwolf'


"func! WordProcessorMode()
"    setlocal textwidth=80
"    setlocal smartindent
"    setlocal spell spelllang=pt_br
"    setlocal noexpandtab
"endfu

"com! WP call WordProcessorMode()


if has("syntax")
    syntax on
    filetype on
    au BufNewFile,BufRead *.jq set filetype=javascript
endif

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.space = "\ua0"

set t_Co=256
if (has("termguicolors"))
    set termguicolors
endif

let g:airline#extensions#tabline#enabled = 1

let g:NERDTreeWinPos = "left"
let g:nerdtree_tabs_open_on_console_startup = 1
let g:tagbar_left = 0
let g:tagbar_width = 25

"hi Normal ctermbg=none

"Syntastic things

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = "X>"
let g:syntastic_warning_symbol = "!>"
let g:syntastic_auto_loc_list = 1
let g:syntastic_style_error_symbol = 'S>'
let g:syntastic_style_warning_symbol = 'S>'
let g:syntastic_auto_jump = 1
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
"au BufWrite * :Autoformat

"indent guides colors
let g:indent_guides_auto_colors = 0 
hi IndentGuidesOdd  ctermbg=lightgrey
hi IndentGuidesEven ctermbg=3
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 2

"indent Line
let g:indentLine_enabled = 1
let g:indentLine_setColors = 1 
let g:indentLine_color_term = 0
let g:indentLine_char = '¦'


"neocomplcache things
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 3
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"deoplete
let g:deoplete#enable_at_startup = 1

function! TabTagbar()
    let tagbar_open = bufwinnr('__Tagbar__') != -1
    if !tagbar_open
        TagbarOpen

        wincmd w
        wincmd J
        wincmd k
        wincmd L
        wincmd H
        wincmd w
        :vertical resize 30
        wincmd w
        wincmd w
    endif
endfunction

function! ToggleNERDTreeAndTagbar()
    let w:jumpbacktohere = 1

    " Detect which plugins are open
    if exists('t:NERDTreeBufName')
        let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
    else
        let nerdtree_open = 0
    endif
    let tagbar_open = bufwinnr('__Tagbar__') != -1

    " Perform the appropriate action
    if !nerdtree_open
        NERDTree
    endif
    if !tagbar_open
        TagbarOpen
    endif

    wincmd J
    wincmd k
    wincmd L

    " Jump back to the original window
    for window in range(1, winnr('$'))
        execute window . 'wincmd w'
        if exists('w:jumpbacktohere')
            unlet w:jumpbacktohere
            wincmd H
            break
        endif
    endfor
    wincmd w
    :vertical resize 30
    wincmd w
    wincmd w
endfunction
"nnoremap <leader>\ :call ToggleNERDTreeAndTagbar()<CR>

"autocmd VimEnter * :call ToggleNERDTreeAndTagbar()
"autocmd TabEnter * :call TabTagbar()

inbow parenthesis
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
    \   'ctermfgs': [28, 127, 20, 58],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \}


