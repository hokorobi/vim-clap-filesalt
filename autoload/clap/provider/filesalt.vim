" Author: hokorobi <hokorobi.hokorobi@gmail.com>
" Description: List files from command result

function! s:source() abort
  let cmdlist = get(g:, 'clap_filesalt_cmdlist', ['files'])
  " TODO: Allow arguments to be specified each time.
  " if !empty(g:clap.provider.args)
  "   " directory
  "   call add(cmdlist, g:clap.provider.args[0])
  "   if len(g:clap.provider.args) > 1
  "     " matched string
  "     call extend(cmdlist, ['-m', g:clap.provider.args[1]], 1)
  "   endif
  " endif
  return clap_filesalt#systemlist(cmdlist)
endfunction

let s:filesalt = {}
let s:filesalt.sink = 'edit'
let s:filesalt.source = function('s:source')

let g:clap#provider#filesalt# = s:filesalt

