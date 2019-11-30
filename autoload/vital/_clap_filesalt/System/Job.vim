" ___vital___
" NOTE: lines between '" ___vital___' is generated by :Vitalize.
" Do not modify the code nor insert new lines before '" ___vital___'
function! s:_SID() abort
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
endfunction
execute join(['function! vital#_clap_filesalt#System#Job#import() abort', printf("return map({'_vital_depends': '', '_vital_healthcheck': '', 'is_available': '', 'start': '', '_vital_loaded': ''}, \"vital#_clap_filesalt#function('<SNR>%s_' . v:key)\")", s:_SID()), 'endfunction'], "\n")
delfunction s:_SID
" ___vital___
let s:t_string = type('')
let s:t_list = type([])

function! s:_vital_loaded(V) abort
  if has('nvim')
    let s:Job = a:V.import('System.Job.Neovim')
  else
    let s:Job = a:V.import('System.Job.Vim')
  endif
endfunction

function! s:_vital_depends() abort
  return [
        \ 'System.Job.Vim',
        \ 'System.Job.Neovim',
        \]
endfunction

function! s:_vital_healthcheck() abort
  if has('patch-8.0.0027') || has('nvim-0.2.0')
    return
  endif
  return 'This module requires Vim 8.0.0027 or Neovim 0.2.0'
endfunction


" Note:
" Vim does not raise E902 on Unix system even the prog is not found so use a
" custom exception instead to make the method compatible.
" Note:
" Vim/Neovim treat String a bit differently so prohibit String as well
function! s:_validate_args(args) abort
  if type(a:args) != s:t_list
    throw 'vital: System.Job: Argument requires to be a List instance.'
  endif
  if len(a:args) == 0
    throw 'vital: System.Job: Argument vector must have at least one item.'
  endif
  let prog = a:args[0]
  if !executable(prog)
    throw printf('vital: System.Job: "%s" is not an executable', prog)
  endif
endfunction

function! s:is_available() abort
  return s:Job.is_available()
endfunction

function! s:start(args, ...) abort
  call s:_validate_args(a:args)
  return s:Job.start(a:args, a:0 ? a:1 : {})
endfunction
