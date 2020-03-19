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
" files
nnoremap <silent> <C-p> :FzfFiles<CR>		

" open buffers
nnoremap <silent> <C-b> :FzfBuffers<CR>

" lines in the current buffer
nnoremap <silent> <C-g> :FzfBLines<CR>

" lines in the loaded buffers
nnoremap <silent> <C-G> :FzfLines<CR>

" Ag search
" nnoremap <silent> <C-b> :FzfAg<CR>

" vim commands
nnoremap <silent> <C-r> :FzfCommands<CR>

" command history
cnoremap <silent> <C-p> :FzfHistory:<CR>

" vim mappings
" nnoremap <silent> <C-b> :FzfMaps<CR>

" misc
nnoremap <silent> <F1> :FzfHelpTags<CR>
inoremap <silent> <F1> <ESC>:FzfHelpTags<CR>
inoremap <silent> <F3> <ESC>:FzfSnippets<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
