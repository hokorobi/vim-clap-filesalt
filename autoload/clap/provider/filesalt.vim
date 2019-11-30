" Author: hokorobi <hokorobi.hokorobi@gmail.com>
" Description: List files from command result

function! s:source() abort
  let cmdlist = get(g:, 'clap_filesalt_cmdlist', ['files'])
  if !empty(g:clap.provider.args)
    call add(cmdlist, g:clap.provider.args[0])
    " TODO: Allow directories to be specified each time.
    " if len(g:clap.provider.args) > 1
    "   call extend(cmdlist, ['-m', g:clap.provider.args[1]], 1)
    " endif
  endif
  return clap_filesalt#systemlist(cmdlist)
endfunction

let s:filesalt = {}
let s:filesalt.sink = 'edit'
let s:filesalt.source = function('s:source')

let g:clap#provider#filesalt# = s:filesalt

