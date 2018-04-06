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
    Expect filereadable(',out') to_be_false

    write seq:,out

    Expect filereadable(',out') to_be_true
    Expect readfile(',out') ==# map(range(5, 10), {_, v -> string(v)})
  end
end
