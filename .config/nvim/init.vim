" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" System and interface
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdcommenter'
Plug 'Chiel92/vim-autoformat'
Plug 'airblade/vim-gitgutter'
" Plug 'majutsushi/tagbar'
Plug 'fishbullet/deoplete-ruby', { 'for': 'ruby' }
Plug 'vim-airline/vim-airline', { 'on': 'AirlineToggle' }
Plug 'jistr/vim-nerdtree-tabs'

" Web devel
Plug 'mattn/emmet-vim', { 'for': ['javascript', 'html', 'vue']}
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim'

" Theme and interface
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'ryanoasis/vim-devicons'

" C family devel
Plug 'zchee/libclang-python3', { 'for': ['c', 'cpp'] }
Plug 'Shougo/neoinclude.vim', { 'for': ['c', 'cpp'] }
Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp'] }


" Initialize plugin system
call plug#end()

set cursorline
set colorcolumn=81
set mouse=a
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=0
colorscheme Benokai
set termguicolors
set guicursor=n-v-c-i:block-Cursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10-blinkon30
:hi Cursor gui=reverse guibg=NONE guifg=NONE
nmap <F2> :Autoformat<CR>
nmap <F5> :NERDTreeToggle<CR>


" Abbreviations useful to save and exit
cab W w | cab Q q | cab Wq wq | cab wQ wq | cab WQ wq
cab Wa wa | cab Qa qa | cab Wqa wqa | cab wQa wqa | cab wqA wqa
cab WQa wqa | cab WqA wqa | cab wQA wqa | cab WQA wqa

" Airline things
let g:airline_theme='atomic'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"Deoplete things
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"Deoplete-clang things
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

"Syntastic things
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = "✘"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_auto_loc_list = 1
let g:syntastic_style_error_symbol = 'S>'
let g:syntastic_style_warning_symbol = 'S>'
let g:syntastic_auto_jump = 0
let g:syntastic_loc_list_height = 5
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = '-std=c++11'

"Nerdtree things
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinWidth = 25
let g:nerdtree_tabs_open_on_startup = 1

"Nerdcommenter things
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1

"Gitgutter things
hi GitGutterAdd          ctermbg=2  ctermfg=2" an added line
hi GitGutterChange       ctermbg=3  ctermfg=3" a changed line
hi GitGutterDelete       ctermbg=1  ctermfg=1" at least one removed line
hi GitGutterChangeDelete ctermbg=4  ctermfg=4" a changed line followed by at least one removed line

