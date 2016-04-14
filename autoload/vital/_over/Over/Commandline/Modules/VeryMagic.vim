scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:module = {
\	"name" : "VeryMagic",
\}

function! s:module.on_execute_pre(cmdline)
	let line = a:cmdline.getline()
	let result = over#parse_substitute(line, 1)
	if result != []
		let [range, slash,pattern, string, flags] = result
		if g:over#command_line#search#very_magic
			let pattern = '\v' . pattern
		endif
		call a:cmdline.setline(
			\ range . "s" . slash . pattern . slash . string . slash . flags)
	endif

	if line =~ '^/.\+' || line =~ '^?.\+'

		if g:over#command_line#search#very_magic
			let line = line[0] . '\v' . line[1:]
		endif

		call a:cmdline.setline(line)
	endif
endfunction

function s:module.priority(...)
	return 1000
endfunction


function! s:make(...)
	let module = deepcopy(s:module)
	return module
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
