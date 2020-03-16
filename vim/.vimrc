" General Vim configuration
	let g:os = substitute(system('uname'), '\n', '', '')

" Install vim-plug if it is not installed
	if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

" Install Vim plugins
	call plug#begin('~/.vim/plugged')
	
	if g:os == "Darwin"
		Plug '/usr/local/opt/fzf'
	endif

	Plug 'junegunn/fzf.vim'
	Plug 'mileszs/ack.vim'
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoUpdateBinaries' }
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'itchyny/lightline.vim'

	Plug 'christoomey/vim-tmux-navigator'

	" required for :GoDecls
    " Plug 'ctrlpvim/ctrlp.vim'
	Plug 'ryanoasis/vim-devicons'

	" sxhkd syntax highlighting
	Plug 'kovetskiy/sxhkd-vim'

	" Color themes
	Plug 'dracula/vim', { 'as': 'dracula' }
	Plug 'tomasiser/vim-code-dark'

	call plug#end()

" General Editor settings
	let mapleader=","
	
	" Change how vim represents characters on the screen
	set encoding=utf-8

	" Set the encoding of files written
	set fileencoding=utf-8

	syntax on
	set autoindent

	" enable true colors both inside and outside of tmux
	if exists('+termguicolors')
		" in order to support true colors inside tmux, below 2 lines are required
		" https://stackoverflow.com/questions/53327486/whats-happening-here-with-vim-inside-tmux-pane
   		let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
   		let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

		" enables true colors
  		set termguicolors
	endif

	" colorscheme codedark
	colorscheme dracula
	
	" to toggle paste mode due to autoindent
	" https://unix.stackexchange.com/questions/199203/why-does-vim-indent-pasted-code-incorrectly
	set pastetoggle=<F2>

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
	set ignorecase 
	set smartcase " ignorecase and smartcase are set. It will search case-insensitively for lowercase entry only
	set incsearch " Shows the match while typing

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

	" move one line up/down
	" http://vim.fandom.com/wiki/Moving_lines_up_or_down 
	if g:os == "Darwin"
		" on OSX ==> https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim/15399297#15399297
		" <ALT+j> ==> ∆ 
		" <ALT+k> ==> ˚
		nnoremap ∆ :m .+1<CR>==
		nnoremap ˚ :m .-2<CR>==
		inoremap ∆ <Esc>:m .+1<CR>==gi
		inoremap ˚ <Esc>:m .-2<CR>==gi
		vnoremap ∆ :m '>+1<CR>gv=gv
		vnoremap ˚ :m '<-2<CR>gv=gv
	elseif g:os == "Linux"
		nnoremap <A-j> :m .+1<CR>==
		nnoremap <A-k> :m .-2<CR>==
		inoremap <A-j> <Esc>:m .+1<CR>==gi
		inoremap <A-k> <Esc>:m .-2<CR>==gi
		vnoremap <A-j> :m '>+1<CR>gv=gv
		vnoremap <A-k> :m '<-2<CR>gv=gv
	endif
	
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
	set mouse=a "Enable mouse mode

	" Open URLs with urlview
	:noremap <leader>u :w<Home>silent <End> !urlview<CR>

" File Management

	" auto-detects file types
	filetype plugin indent on
	
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


" ==================== Netrw =====================
" netrw directory browser settings
let g:netrw_liststyle=3 	" use tree list view by default
let g:netrw_banner=0 		" remove current directory banner
let g:netrw_winsize=25		" set window size ratio (i.e. %25 of the page)
let g:netrw_browse_split=4	" open in previous window (like NERDTree)
let g:netrw_altv=1
let	g:netrw_dirhistmax = 0 	" disable netrw history


" ==================== Gopass ====================
" disable unsecure storage of temporary vim files
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

" ==================== NerdTree ====================
" For toggling
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1

" Future stuff
	"Swap line
	"Insert blank below and above


" ========== ACK (ag - silver searcher)==========
" fzf.vim also adds an Ag command, which is not related to Ack command added by this plugin

" use 'ag' for the ack.vim plugin, if it is available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Ack jumps to the first quick fix. Use 'bang' option always to open up the quick fix list, instead
cnoreabbrev Ack Ack!
" nnoremap <Leader>a :Ack!<Space>


" ==================== FZF ======================
" Add namespace for fzf.vim exported Vim commands
let g:fzf_command_prefix = 'Fzf'

" Key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Add layout
let g:fzf_layout = { 'down': '~40%' }

" Enable per-command history
let g:fzf_history_dir = '$XDG_DATA_HOME/fzf-history'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Mappings
nnoremap <silent> <C-p> :FzfFiles<CR>
nnoremap <silent> <C-b> :FzfBuffers<CR>
nnoremap <silent> <C-g> :FzfBLines<CR>
nnoremap <silent> <C-G> :FzfLines<CR>
nnoremap <silent> <C-r> :FzfCommands<CR>
cnoremap <silent> <C-p> :FzfHistory:<CR>
nnoremap <silent> <F1> :FzfHelpTags<CR>
inoremap <silent> <F1> <ESC>:FzfHelpTags<CR>
inoremap <silent> <F3> <ESC>:FzfSnippets<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" ==================== vim-go ======================
" prefer fzf over ctrlp.vim plugin (to replace ctrlp plugin w/ fzf entirely)
let g:go_decls_mode = 'fzf'

" run goimports along gofmt on each save 
let g:go_fmt_command = "goimports"     

" activates autocomplete prompt when '.' is pressed
au filetype go inoremap <buffer> . .<C-x><C-o>

" If you want to disable gofmt on save
" let g:go_fmt_autosave = 0

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'


" tabs
au FileType go set noexpandtab
au FileType go set shiftwidth=4		" sw - when indenting with '>', use 4 spaces width
au FileType go set softtabstop=4	" sts - control <tab> and <bs> keys to match tabstop
au FileType go set tabstop=4 		" ts - show existing tab with 4 spaces width


" colors
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_functions_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_tesh_show_name = 1
let g:go_auto_type_info = 1

