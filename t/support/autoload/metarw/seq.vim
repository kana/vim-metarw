function! metarw#seq#read(fakepath)
  let [scheme, from, to] = split(a:fakepath, ':')

  return ['read', printf(
  \   '!seq %s %s',
  \   from,
  \   to,
  \ )]
endfunction
