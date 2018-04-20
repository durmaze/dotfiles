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


