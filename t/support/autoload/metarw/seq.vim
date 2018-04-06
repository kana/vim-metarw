function! metarw#seq#read(fakepath)
  let [scheme, from, to] = split(a:fakepath, ':')

  return ['read', printf(
  \   '!seq %s %s',
  \   from,
  \   to,
  \ )]
endfunction

function! metarw#seq#write(fakepath, line1, line2, append_p)
  let [scheme, name] = split(a:fakepath, ':')

  return ['write', printf(
  \   '!cat >"%s"',
  \   name,
  \ )]
endfunction
