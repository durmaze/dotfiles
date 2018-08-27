" Install vim-plug if it is not installed
	if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

" Install Vim plugins
	call plug#begin('~/.vim/plugged')

	Plug '/usr/local/opt/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoUpdateBinaries' }
	Plug 'itchyny/lightline.vim'

	Plug 'christoomey/vim-tmux-navigator'

	" required for :GoDecls
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'ryanoasis/vim-devicons'

	call plug#end()

" General Vim settings
	set encoding=utf8

	syntax on
	let mapleader=","
	set autoindent
	set tabstop=4
	set shiftwidth=4
	set dir=/tmp/
	set relativenumber
	set number

	" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
	set clipboard^=unnamed
	set clipboard^=unnamedplus
	
	" autowrite when :make like tools (e.g. :GoBuild) are called
	set autowrite

	set cursorline
	hi Cursor ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold

	set hlsearch " Highlight found searches
	nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>
	nnoremap <C-c> :set norelativenumber<CR>:set nonumber<CR>:echo "Line numbers turned off."<CR>
	nnoremap <C-n> :set relativenumber<CR>:set number<CR>:echo "Line numbers turned on."<CR>

	nnoremap n nzzzv
	nnoremap N Nzzzv

	nnoremap H 0
	nnoremap L $
	nnoremap J G
	nnoremap K gg
	
	vnoremap H 0
	vnoremap L $
	vnoremap J G
	vnoremap K gg
	
	" map jj to ESC in order to stay in home row for quiting insert mode
	inoremap jj <Esc>

	" move one line up/down on OSX ==> http://vim.wikia.com/wiki/Moving_lines_up_or_down
	" <ALT+j> ==> ∆ 
	" <ALT+k> ==> ˚
	nnoremap ∆ :m .+1<CR>==
	nnoremap ˚ :m .-2<CR>==
	inoremap ∆ <Esc>:m .+1<CR>==gi
	inoremap ˚ <Esc>:m .-2<CR>==gi
	vnoremap ∆ :m '>+1<CR>gv=gv
	vnoremap ˚ :m '<-2<CR>gv=gv

	map <tab> %

	" Faster split switching
	map <C-j> <C-W>j
	map <C-k> <C-W>k
	map <C-h> <C-W>h
	map <C-l> <C-W>l

	set backspace=indent,eol,start

	nnoremap <Space> za
	nnoremap <leader>z zMzvzz

	nnoremap vv 0v$

	set listchars=tab:\|\
	nnoremap <leader><tab> :set list!<cr>
	set pastetoggle=<F2>
	set mouse=a "Enable mouse mode
	set incsearch 					" Shows the match while typing

" Language-specific 
	" General
		inoremap <leader>for <esc>Ifor (int i = 0; i < <esc>A; i++) {<enter>}<esc>O<tab>
		inoremap <leader>if <esc>Iif (<esc>A) {<enter>}<esc>O<tab>

	" Java
		inoremap <leader>sys <esc>ISystem.out.println(<esc>A);
		vnoremap <leader>sys yOSystem.out.println(<esc>pA);


" File Management
	inoremap <leader>w <Esc>:w<CR>
	nnoremap <leader>w :w<CR>

	inoremap <leader>q <ESC>:q<CR>
	nnoremap <leader>q :q<CR>

	inoremap <leader>x <ESC>:x<CR>
	nnoremap <leader>x :x<CR>

" Window Management
	nnoremap <leader>e :Ex<CR>
	nnoremap <leader>t :tabnew<CR>:Ex<CR>
	nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
	nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>

" Return to the same line you left off (vim) at
	augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
	augroup END
	
" ==================== NerdTree ====================
" For toggling
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1

" Future stuff
	"Swap line
	"Insert blank below and above

