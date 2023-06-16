let g:vmp_script_path = resolve(expand('<sfile>:p:h'))
let g:viewmd_dir = g:vmp_script_path . '/viewmd'
"let g:viewmd_bin = g:viewmd_dir . '/viewmd'

let g:viewmd_bin = 'viewmd'

" default hotkey
if !exists("g:vim_viewmd_preview_hotkey")
  let g:vim_markdown_preview_hotkey='<C-l>'
endif

function! Vim_Markdown_Preview()
  let l:git_repo      = 'https://github.com/wilbura009/viewmd'
  let l:err_no_bin    = 'viewmd not found'
  let l:msg_abort     = 'Aborting... see ' . l:git_repo . ' for more info.'
  let l:msg_install   = 'Would you like to download and install it (y/n) ?'
  let l:msg_pw_req    = 'Note: You will be prompted for your password to install viewmd.'
  let l:msg_dwn_ld    = 'Downloading viewmd...'
  let l:msg_inst      = "Installing viewmd..."
  let l:msg_inst_done = 'Done installing viewmd.'
  let l:msg_clean     = 'Cleaning up...'
  let l:msg_done      = 'Done!'

  if !executable(g:viewmd_bin)
    echomsg l:err_no_bin . ': ' . l:msg_install
    echomsg l:msg_pw_req
    let l:answer = input('')
    if l:answer != 'y'
      echomsg l:msg_abort
      return
    endif

    echo "\n"
    echomsg l:msg_dwn_ld
    call system('git clone ' . l:git_repo . ' ' . g:viewmd_dir)
    echomsg l:msg_inst
    echo "\n"

    call system('cd ' . g:viewmd_dir . ' && make install-home && make cleanall')
    echomsg l:msg_inst_done
    echomsg l:msg_clean
    call system('rm -rf ' . g:viewmd_dir)

    echo "\n"
    echomsg l:msg_done
    echo "\n"

  endif

  let b:curr_file = expand('%:p')
  let b:cmd = g:viewmd_bin . ' ' . b:curr_file
  echo b:cmd
  call system(b:cmd . ' &')

endfunction

:exec 'autocmd Filetype markdown,md map <buffer> ' . g:vim_markdown_preview_hotkey . ' :call Vim_Markdown_Preview()<CR>'
