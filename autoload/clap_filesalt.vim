let s:V = vital#clap_filesalt#new()
let s:Job = s:V.import('System.Job')

function! s:_on_stdout(data) abort dict
  let self.stdout[-1] .= a:data[0]
  call extend(self.stdout, a:data[1:])
endfunction

function! s:_on_stderr(data) abort dict
  let self.stderr[-1] .= a:data[0]
  call extend(self.stderr, a:data[1:])
endfunction

function! s:jobstartwrap(list) abort
  if type(a:list[0]) == v:t_list
    let args = a:list[0]
  else
    let args = a:list
  endif

  let job = s:Job.start(args, {
        \ 'stdout': [''],
        \ 'stderr': [''],
        \ 'on_stdout': function('s:_on_stdout'),
        \ 'on_stderr': function('s:_on_stderr'),
        \})
  let exit_status = job.wait()
  return {
        \ 'exit_status': exit_status,
        \ 'stdout': job.stdout,
        \ 'stderr': job.stderr,
        \}
endfunction

function! clap_filesalt#systemlist(...) abort
  let job = s:jobstartwrap(a:000)
  if job.exit_status
    return job.stderr
  else
    return job.stdout
  endif
endfunction

