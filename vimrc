"File Opts
set nobackup
set noswapfile
set undodir=$HOME/.vim/undo
set undofile
set clipboard=unnamedplus

"Display
filetype plugin on
syntax on
set scrolloff=10

set incsearch
set hlsearch
set wildmenu
set noruler
set mouse=nc
set completeopt=longest,menu
"clear after leaving vim
au VimLeave * :!clear 
set background=dark

"Real Tabs
set autoindent
set noexpandtab
set shiftwidth=4
set tabstop=4

"Keys
let mapleader = " "
let maplocalleader = " "
set backspace=indent,start
vnoremap p "_dP 
" 	Navigation
nnoremap H :call BufferPrevSkipTerminal()<CR>
nnoremap L :call BufferNextSkipTerminal()<CR>
nnoremap <C-s> :vsplit<CR>
nnoremap <C-c> :split<CR>
nnoremap <C-d> :close<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-t> :vert term<CR>
nnoremap <leader>nv :e $HOME/.vimrc<CR>
nnoremap <C-x> <Nop>
inoremap <C-x> <Nop>
vnoremap <C-x> <Nop>

nnoremap <C-b> :call JumpToTabUnderCursor()<CR>
nnoremap <C-p> :call JumpToTabUnderCursorSplit()<CR>

"	WindowNav
set splitbelow
set splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" CursorLines set, then overrid when in source code file
hi CursorLine cterm=none ctermbg=237
hi clear CursorColumn
hi link CursorColumn CursorLine 
hi LineNR cterm=none ctermfg=238
hi CursorLineNR cterm=bold ctermfg=white ctermbg=237
" Theme
hi Comment ctermfg=Gray
hi Todo cterm=bold ctermbg=NONE ctermfg=204
hi cConstant cterm=bold ctermfg=224
hi PreProc cterm=bold ctermfg=222
hi Type cterm=bold ctermfg=223
hi Statement cterm=bold ctermfg=222
hi clear Matchparen
hi Matchparen cterm=bold ctermfg=204
hi Macro cterm=bold ctermfg=224
hi Identifier ctermfg=224
hi Error ctermbg=NONE


if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Autocmds for source code files
au bufnewfile,bufRead *.h set ft=c
au bufnewfile,bufRead *.pyx set ft=python
au bufnewfile,bufRead keg set ft=yaml
augroup CODE
	autocmd!
	autocmd FileType c,cpp,python,sh,go,zig,html set laststatus=2
	autocmd FileType c,cpp,python,sh,go,zig,html set nu "Line Column
	autocmd	FileType c,cpp,python,sh,go,zig,html set cursorline
	autocmd FileType c,cpp,python,sh,go,zig,html set relativenumber 
	autocmd FileType c,cpp,python,sh,go,zig,html set numberwidth=2
	autocmd FileType c,cpp,python,sh,go,zig,html set nowrap
	autocmd FileType c,cpp,python,sh,go,zig,html set ruler
	autocmd FileType c,cpp,python,sh,go,zig,html inoremap ' ''<ESC>i
	autocmd FileType html,css EmmetInstall
augroup END

"PLUGIN
" vim-plug https://github.com/junegunn/vim-plug
call plug#begin()
	Plug 'tpope/vim-commentary'	
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug '42Paris/42header'
	" Plug 'tpope/vim-fireplace'
	" Plug 'mattn/emmet-vim'
call plug#end()
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key = '<C-k>'
let g:user42 = 'psoler-u'
let g:mail42 = 'psoler-u@student.42madrid.com'

"	File Explorer
nnoremap <leader>e :vsplit<CR> :edit .<CR>
let g:netrw_banner=0
let g:netrw_browser_split=4 " prior window
let g:netrw_altv=1
let g:netrw_liststyle=3 " tree
let g:netrw_list_hide=netrw_gitignore#Hide()
"
"FZF: set $FZF_DEFAULT_COMMAND=ag -g "" to ignore .git
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fg :Ag<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>ft :Tags<CR>

" Config vim local to project
if filereadable(".project.vimrc") 
	so .project.vimrc
endif

""Syntax Expansion Example
"fun! ExtendCSyntax()
"	syn keyword cType I8
"	syn keyword cType I16
"endfu
" autocmd FileType c :call ExtendCSyntax()

"Snips - Example
"nnoremap ,html :-1read $HOME/.vim/snips/html5.html<CR>
"
" Ignore terminal when moving buffers
function! BufferNextSkipTerminal()
	let start_buffer = bufnr('%')
	bn!
	while &buftype ==# 'terminal' && bufnr('%') != start_buffer
		bn!
	endwhile
endfunction

function! BufferPrevSkipTerminal()
	let start_buffer = bufnr('%')
	bp!
	while &buftype ==# 'terminal' && bufnr('%') != start_buffer
		bp!
	endwhile
endfunction

function! JumpToTabUnderCursor()
	let word = expand('<cword>')
	execute 'tag ' . word
endfunction

function! JumpToTabUnderCursorSplit()
	let word = expand('<cword>')
	execute 'vsp'
	execute 'tag ' . word
endfunction

