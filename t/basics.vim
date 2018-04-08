set runtimepath+=t/support
runtime plugin/metarw.vim

describe 'metarw'
  after
    % bdelete!
    !rm -f ,out
  end

  it 'enables to read from a fakepath via :read'
    Expect getline(1, '$') ==# ['']
    edit seq:10:39
    Expect getline(1, '$') ==# map(range(10, 39), {_, v -> string(v)})
  end

  it 'enables to write to a fakepath via :write'
    put =range(5, 10)
    1 delete _
    Expect getline(1, '$') ==# map(range(5, 10), {_, v -> string(v)})
    Expect &l:modified to_be_true
    Expect filereadable(',out') to_be_false

    write seq:,out

    Expect filereadable(',out') to_be_true
    Expect &l:modified to_be_false
    Expect readfile(',out') ==# map(range(5, 10), {_, v -> string(v)})
  end

  it 'enables to read from a fakepath via Funcref'
    Expect getline(1, '$') ==# ['']
    edit func:range(8,8+8)
    Expect getline(1, '$') ==# map(range(8, 16), {_, v -> string(v)})
  end

  it 'enables to write to a fakepath via Funcref'
    put =range(5, 20)
    1 delete _
    Expect getline(1, '$') ==# map(range(5, 20), {_, v -> string(v)})
    Expect filereadable(',out') to_be_false

    8,12 write func:writefile(getline(a:line1,a:line2)+[a:append_p],',out')

    Expect filereadable(',out') to_be_true
    Expect readfile(',out') ==# ['12', '13', '14', '15', '16', '0']

    13,15 write >> func:writefile(getline(a:line1,a:line2)+[a:append_p],',out')

    Expect filereadable(',out') to_be_true
    Expect readfile(',out') ==# ['17', '18', '19', '1']
  end
end
