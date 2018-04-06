function! metarw#func#read(fakepath)
  let [scheme, expr] = split(a:fakepath, ':')

  return ['read', {-> eval(expr)}]
endfunction
