set runtimepath+=t/support
runtime plugin/metarw.vim

describe 'metarw'
  after
    %bdelete!
  end

  it 'enables to read from a fakepath'
    Expect getline(1, '$') ==# ['']
    edit seq:10:39
    Expect getline(1, '$') ==# map(range(10, 39), {_, v -> string(v)})
  end
end
