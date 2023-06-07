let g:vmp_script_path = resolve(expand('<sfile>:p:h'))


if !exists("g:vim_viewmd_preview_hotkey")
    let g:vim_markdown_preview_hotkey='<C-l>'
endif

function! Vim_Markdown_Preview()
  let b:curr_file = expand('%:p')
  let b:cmd = g:vmp_script_path . '/viewmd/viewmd ' . b:curr_file

  call system(b:cmd . ' &')
endfunction

:exec 'autocmd Filetype markdown,md map <buffer> ' . g:vim_markdown_preview_hotkey . ' :call Vim_Markdown_Preview()<CR>'
