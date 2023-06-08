let g:vmp_script_path = resolve(expand('<sfile>:p:h'))
let g:viewmd_dir = g:vmp_script_path . '/viewmd'
let g:viewmd_bin = g:viewmd_dir . '/viewmd'

" default hotkey
if !exists("g:vim_viewmd_preview_hotkey")
  let g:vim_markdown_preview_hotkey='<C-l>'
endif


if !isdirectory(g:viewmd_dir)
  echon 'viewmd directory not found: ' . g:viewmd_dir
  echo 'Would you like to download it? [y/n]'
  let g:answer = input('')
  if g:answer == 'y'
    echo 'Downloading viewmd...'
    call system('git clone https://github.com/wilbura009/viewmd' . ' ' . g:viewmd_dir)
    if !filereadable(g:viewmd_bin)
      echo 'viewmd binary not found: Creating binary...' . g:viewmd_bin
      call system('cd ' . g:viewmd_dir . ' && make && make clean')
    endif
  else
    echo 'Aborting...'
    exit
  endif
else " viewmd directory exists
  if !filereadable(g:viewmd_bin)
    echo 'viewmd binary not found: Creating binary...' . g:viewmd_bin
    call system('cd ' . g:viewmd_dir . ' && make && make clean')
  endif
endif

function! Vim_Markdown_Preview()

  if !filereadable(g:viewmd_bin)
    echon 'viewmd binary not found: creating binary' . g:viewmd_bin
    call system('cd ' . g:viewmd_dir . ' && make && make clean')
  else
    let b:curr_file = expand('%:p')
    let b:cmd = g:viewmd_bin . ' ' . b:curr_file
    echo b:cmd
    call system(b:cmd . ' &')
  endif

endfunction

:exec 'autocmd Filetype markdown,md map <buffer> ' . g:vim_markdown_preview_hotkey . ' :call Vim_Markdown_Preview()<CR>'
