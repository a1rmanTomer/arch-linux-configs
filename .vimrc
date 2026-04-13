" =============================================================================
" 1. CORE SETTINGS
" =============================================================================
set nocompatible
filetype plugin indent on
syntax on
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

" השלמה אוטומטית - תפריט מודרני
set completeopt=noinsert,menuone,noselect

" =============================================================================
" 2. INDENTATION (C# / .NET Standards)
" =============================================================================
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set nowrap

" =============================================================================
" 3. UI & UX
" =============================================================================
set number
set relativenumber
set cursorline
set scrolloff=4
set mouse=a
set clipboard=unnamedplus
set wildmenu
set wildmode=longest:full,full

" =============================================================================
" 4. SECURITY & HYGIENE
" =============================================================================
set noswapfile
set undodir=~/.vim/undodir
set undofile

" =============================================================================
" 5. FILE EXPLORER (Netrw)
" =============================================================================
let g:netrw_winsize = 20
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

nnoremap <C-b> :Lexplore<CR>
inoremap <C-b> <Esc>:Lexplore<CR>
vnoremap <C-b> <Esc>:Lexplore<CR>

" =============================================================================
" 6. PLUGINS (vim-plug)
" =============================================================================
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-sensible'
Plug 'Raimondi/delimitMate'
call plug#end()

" === Plugin Configurations ===
let g:delimitMate_expand_cr = 1
colorscheme BlackSea

" ALE Configuration
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = { 'cs': ['csc'] }

" Navigation Keybindings
nnoremap <PageDown> :bn<CR>
nnoremap <PageUp> :bp<CR>
nnoremap <C-f> :BLines<CR>
inoremap <C-f> <C-o>:BLines<CR>
nnoremap <leader>= mzgg=G`z

" =============================================================================
" 7. COC.NVIM (Vim-Style Navigation & C#)
" =============================================================================
let g:coc_config_home = '~/.vim/'

" --- Vim-Style Menu Navigation & Tab Select ---

" טאב: אם התפריט פתוח - מאשר בחירה. אם סגור - עושה טאב רגיל או פותח תפריט.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" ניווט בתפריט עם Ctrl+j ו-Ctrl+k (תנועת Vim בתוך ה-Insert Mode)
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

" אנטר: עושה ירידת שורה רגילה (כדי שלא יציק כשרוצים רק לרדת שורה)
inoremap <expr> <CR> coc#pum#visible() ? "\<C-g>u\<CR>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" --- LSP Navigation & Diagnostics ---
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" --- Refactoring & Tools ---
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf <Plug>(coc-fix-current)
command! -nargs=0 Format :call CocActionAsync('format')

" עיצוב קוד אוטומטי בשמירה
autocmd BufWritePre *.cs silent! call CocAction('format')
