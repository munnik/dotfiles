if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
"File Search:
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"File Browser:
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mkitt/tabline.vim'
Plug 'ryanoasis/vim-devicons'
"Color And Syntax:
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
"Golang:
Plug 'fatih/vim-go'
"Autocomplete:
Plug 'neoclide/coc.nvim'
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
"Snippets:
Plug 'SirVer/ultisnips'
"Git:
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Status line:
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

"COPY/PASTE:
"-----------
"Increases the memory limit from 50 lines to 1000 lines
:set viminfo='100,<1000,s10,h

"NUMBERING:
"----------
:set number
:set relativenumber

"INDENTATION:
"------------
"Highlights code for multiple indents without reselecting
vnoremap < <gv
vnoremap > >gv
set smartindent
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

"COLOR:
"------
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
colorscheme onedark
"AIRLINE:
"--------
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"AUTOCOMPLETE:
"-------------

"SNIPPETS:
"---------
"Change default expand since TAB is used to cycle options
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"FILE SEARCH:
"------------
"allows FZF to open by pressing CTRL-F
map <C-p> :FZF<CR>
"allow FZF to search hidden 'dot' files
let $FZF_DEFAULT_COMMAND = "find -L"

"FILE BROWSER:
"-------------
"allows NERDTree to open/close by typing 'n' then 't'
map nt :NERDTreeTabsToggle<CR>
"Start NERDtree when dir is selected (e.g. "vim .") and start NERDTreeTabs
let g:nerdtree_tabs_open_on_console_startup=2
"Add a close button in the upper right for tabs
let g:tablineclosebutton=1
"Automatically find and select currently opened file in NERDTree
let g:nerdtree_tabs_autofind=1
"Add folder icon to directories
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
"Hide expand/collapse arrows
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
highlight! link NERDTreeFlags NERDTreeDir

"SHORTCUTS:
"----------
"Open file at same line last closed
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
endif

"SOURCING:
"---------
"Automatically reloads neovim configuration file on write (w)
autocmd! bufwritepost init.vim source %

"MOUSE:
"------
"Allow using mouse helpful for switching/resizing windows
set mouse+=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

"TEXT SEARCH:
"------------
"Makes Search Case Insensitive
set ignorecase

"SWAP:
"-----
set dir=~/.local/share/nvim/swap/

"GIT (FUGITIVE):
"---------------
map fgb :Gblame<CR>
map fgs :Gstatus<CR>
map fgl :Glog<CR>
map fgd :Gdiff<CR>
map fgc :Gcommit<CR>
map fga :Git add %:p<CR>

"SYNTAX HIGHLIGHTING:
"--------------------
syntax on

"HIGHLIGHTING:
"-------------
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Highlight the current line the cursor is on
set cursorline

"ENCODING:
"---------
set encoding=utf-8
set fileencoding=utf-8

"GOLANG:
"-------
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0

"COC:
"----
let g:coc_global_extensions = ['coc-css', 'coc-go', 'coc-html', 'coc-json', 'coc-python', 'coc-spell-checker', 'coc-sql', 'coc-tsserver', 'coc-vetur', 'coc-vimlsp']
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
