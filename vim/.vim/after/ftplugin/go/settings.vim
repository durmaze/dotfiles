" use spaces for tabs
setlocal noexpandtab
setlocal shiftwidth=4	" sw - when indenting with '>', use 4 spaces width
setlocal softtabstop=4	" sts - control <tab> and <bs> keys to match tabstop
setlocal tabstop=4 		" ts - show existing tab with 4 spaces width

setlocal updatetime=800

	
" prefer fzf over ctrlp.vim plugin (to replace ctrlp plugin w/ fzf entirely)
let g:go_decls_mode = 'fzf'

" :GoDecls/:GoDeclsDir
let g:go_decls_includes = "func,type"


" If you want to disable gofmt on save
" let g:go_fmt_autosave = 1

" fail silently for GoImports errors while saving the file
" let g:go_fmt_fail_silently = 1

" use goimports instead of gofmt
let g:go_fmt_command = "goimports"

" show failed tests before errors and logs
let g:go_test_show_name = 1
" let g:go_test_timeout = '10s'	

" makes all list types (location list and quickfix) to be quickfix
let g:go_list_type = "quickfix"

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" show GoInfo at cursor
let g:go_auto_type_info = 1

" use camelcase for go tags (default is snake_case)
let g:go_modifytags_transform = 'camelcase'

" use camelcase for json tag generation instead of snake_case
let g:go_addtags_transform = "camelcase"

" linting
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"


" motion (motion support for golang)
" if (inner function), af (a function) => dif, yif, vif, ...
" include comments in function object	
let g:go_textobj_include_function_doc = 1

" highlighting
" too much highlighting affects vim performance!!
let g:go_highlight_types = 1
let g:go_highlight_structs = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_functions_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_sameids = 1 					" highlight same identifiers
