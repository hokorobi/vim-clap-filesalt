" Author: hokorobi <hokorobi.hokorobi@gmail.com>
" Description: List files from command result

function! s:source() abort
  let cmdlist = get(g:, 'clap_filesalt_cmdlist', ['files'])
  " if empty(g:clap.provider.args)
  "   return ['Enter command list.']
  " endif
  return clap_filesalt#systemlist(cmdlist)
endfunction

let s:filesalt = {}
let s:filesalt.sink = 'edit'
let s:filesalt.source = function('s:source')

let g:clap#provider#filesalt# = s:filesalt

