let g:vmp_script_path = resolve(expand('<sfile>:p:h'))
let g:viewmd_dir = g:vmp_script_path . '/viewmd'
"let g:viewmd_bin = g:viewmd_dir . '/viewmd'

let g:viewmd_bin = 'viewmd'

" default hotkey
if !exists("g:vim_viewmd_preview_hotkey")
  let g:vim_markdown_preview_hotkey='<C-l>'
endif

function! Vim_Markdown_Preview()
  if !isdirectory(g:viewmd_dir)
    echo 'Downloading viewmd...'
    call system('git clone https://github.com/wilbura009/viewmd' . ' ' . g:viewmd_dir)
    echo 'Installing viewmd...'
    call system('cd ' . g:viewmd_dir . ' && make install-noroot && make cleanall')

    if !isdirectory(g:viewmd_dir)
      echo 'Failed to download viewmd. Please install viewmd manually at https://github.com/wilbura009/viewmd'
      return
    endif
  endif

  let b:curr_file = expand('%:p')
  let b:cmd = g:viewmd_bin . ' ' . b:curr_file
  echo b:cmd
  call system(b:cmd . ' &')

endfunction

:exec 'autocmd Filetype markdown,md map <buffer> ' . g:vim_markdown_preview_hotkey . ' :call Vim_Markdown_Preview()<CR>'
