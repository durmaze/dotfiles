" mappings
" ]] => next method motion, [[ => prev method motion
" K => shows doc

" map <C-n> :cnext<CR>
" map <C-m> :cprevious<CR>
" nnoremap <leader>a :cclose<CR>

nmap <leader>r  <Plug>(go-run)
nmap <leader>t  <Plug>(go-test)
" nmap <Leader>c <Plug>(go-coverage-toggle)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction
	
nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" disabled, since it is shown in the lastline
" nmap <Leader>i <Plug>(go-info)

" :GoAlternate mappings
command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" activates autocomplete prompt when '.' is pressed
inoremap <buffer> . .<C-x><C-o>

