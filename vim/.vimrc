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
	
	" autowrite when :make like tools (e.g. :GoBuild) are called
	set autowrite

	set cursorline
	hi Cursor ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold

	set hlsearch
	nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>
	nnoremap <C-c> :set norelativenumber<CR>:set nonumber<CR>:echo "Line numbers turned off."<CR>
	nnoremap <C-n> :set relativenumber<CR>:set number<CR>:echo "Line numbers turned on."<CR>

	nnoremap n nzzzv
	nnoremap N Nzzzv

	nnoremap H 0
	nnoremap L $
	nnoremap J G
	nnoremap K gg
	
	" move one line up/down on OSX
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
	set mouse=a
	set incsearch

" Language-specific 
	" General
		inoremap <leader>for <esc>Ifor (int i = 0; i < <esc>A; i++) {<enter>}<esc>O<tab>
		inoremap <leader>if <esc>Iif (<esc>A) {<enter>}<esc>O<tab>

	" Java
		inoremap <leader>sys <esc>ISystem.out.println(<esc>A);
		vnoremap <leader>sys yOSystem.out.println(<esc>pA);

	" Golang
	" use spaces
	autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

	" map <C-n> :cnext<CR>
	" map <C-m> :cprevious<CR>
	" nnoremap <leader>a :cclose<CR>

	autocmd FileType go nmap <leader>r  <Plug>(go-run)
	autocmd FileType go nmap <leader>t  <Plug>(go-test)
	" autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
	
	" run :GoBuild or :GoTestCompile based on the go file
	function! s:build_go_files()
		let l:file = expand('%')
		if l:file =~# '^\f\+_test\.go$'
			call go#test#Test(0, 1)
		elseif l:file =~# '^\f\+\.go$'
			call go#cmd#Build(0)
		endif
	endfunction
		
	autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

	" :GoAlternate mappings
	autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
	autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
	autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
	autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

	" :GoInfo
		" autocmd FileType go nmap <Leader>i <Plug>(go-info)

		" show GoInfo at cursor
		let g:go_auto_type_info = 1
		set updatetime=800

	" makes all list types (location list and quickfix) to be quickfix
	" let g:go_list_type = "quickfix"
	" let g:go_test_timeout = '10s'	
	
	" use goimports instead of gofmt
	let g:go_fmt_command = "goimports"
	
	" fail silently for GoImports errors while saving the file
	" let g:go_fmt_fail_silently = 1
	
	" use camelcase for json tag generation instead of snake_case
	let g:go_addtags_transform = "camelcase"

	" motion (motion support for golang)
	" if (inner function), af (a function) => dif, yif, vif, ...
	" include comments in function object	
	let g:go_textobj_include_function_doc = 1

	" highlighting
		" too much highlighting affects vim performance!!
		let g:go_highlight_types = 1
		let g:go_highlight_fields = 1
		let g:go_highlight_functions = 1
		let g:go_highlight_methods = 1
		let g:go_highlight_operators = 1
		let g:go_highlight_extra_types = 1

		" :GoSameIds
		let g:go_auto_sameids = 1
		
	" linting
	let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
	let g:go_metalinter_autosave = 1
	let g:go_metalinter_autosave_enabled = ['vet', 'golint']
	let g:go_metalinter_deadline = "5s"

	" :GoDecls/:GoDeclsDir
	let g:go_decls_includes = "func,type"


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

