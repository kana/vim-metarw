function! metarw#func#read(fakepath)
  let [scheme, expr] = split(a:fakepath, ':')

  return ['read', {-> eval(expr)}]
endfunction

function! metarw#func#write(fakepath, line1, line2, append_p)
  let [_scheme, expr] = split(a:fakepath, 'func:', 1)

  return ['write', {-> eval(expr)}]
endfunction
