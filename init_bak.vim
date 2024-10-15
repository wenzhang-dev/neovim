set encoding=utf-8
set expandtab ts=4 sw=4 ai
"set tabstop=2
"set shiftwidth=2
"set softtabstop=2
set ignorecase
set smartcase
set notimeout
set mouse=a
set nofoldenable

"set clipboard=unnamedplus

let mapleader = "\<SPACE>" " defualt ,

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

  " highlight
  Plug 'cateduo/vsdark.nvim'

  " file explorer
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

  " lsp
  " Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc.nvim', {'tag': 'v0.0.82', 'do': 'yarn install --frozen-lockfile'}

  " auto indent
  Plug 'Yggdroot/indentLine', {'on': 'IndentLinesToggle'}

  " file finder
  "Plug 'Yggdroot/LeaderF' ", { 'do': ':LeaderfInstallCExtension' }
  "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  " open-ai chatgpt
  " Plug 'madox2/vim-ai', { 'on': 'AIChat' }

  " multi-windows
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

  " tagbar
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

  " clang-format
  Plug 'rhysd/vim-clang-format', { 'on': 'ClangFormat' }

  " git
  Plug 'lewis6991/gitsigns.nvim'

  " Plug 'tveskag/nvim-blame-line', { 'on': 'ToggleBlameLine' }

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


" ==== rhysd/vim-clang-format ====
let g:clang_format#command = 'clang-format'
nmap <F4> :ClangFormat<cr>
" autocmd FileType c ClangFormatAutoEnable
let g:clang_format#detect_style_file = 1

" ==== preservim/nerdtree ====
nnoremap <LEADER>e :NERDTreeToggle<CR>

" ==== cateduo/vsdark.nvim ====
set termguicolors
let g:vsdark_style = "dark"
colorscheme vsdark

" ==== neoclide/coc.nvim ====

" coc extensions
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-vimlsp',
      \ 'coc-cmake',
      \ 'coc-highlight',
      \ 'coc-pyright'
      \ ]


nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f <Plug>(coc-format-selected)
command! -nargs=0 Format :call CocAction('format')nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f <Plug>(coc-format-selected)
command! -nargs=0 Format :call CocAction('format')

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! PrettyToggle()
  let l:number = &number
  let l:relativenumber = &relativenumber
  let l:signcolumn = &signcolumn

  if l:number
    setlocal nonumber
    setlocal norelativenumber
    setlocal signcolumn=no
  else
    setlocal number
    setlocal relativenumber
    setlocal signcolumn=number
  endif

  if exists(':IndentLinesToggle')
    silent IndentLinesToggle
  endif

endfunction


let g:indentLine_enabled = 0
call PrettyToggle()

map <leader>y :call PrettyToggle()<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:python3_host_prog = '/usr/bin/python3.6'

" bufferline setting
nnoremap <leader>1 :BufferLineGoToBuffer 1<cr>
nnoremap <leader>2 :BufferLineGoToBuffer 2<cr>
nnoremap <leader>3 :BufferLineGoToBuffer 3<cr>
nnoremap <leader>4 :BufferLineGoToBuffer 4<cr>
nnoremap <leader>0 :BufferLineCycleNext<cr>

" git
nnoremap <silent> <leader>g :Gitsigns toggle_current_line_blame<CR>

" tagbar
nmap <leader>t :TagbarToggle<cr>

set termguicolors

lua << EOF
require("bufferline").setup{
    options = {
--        mode = "tabs",
        number = "ordinal",
    }
}
require("gitsigns").setup()
EOF
