set runtimepath+=t/support
runtime plugin/metarw.vim

function! F()
  return metarw#is_preparing_to_edit()
endfunction

describe 'metarw#is_preparing_to_edit'
  after
    % bdelete!
  end

  it 'returns true while :edit'
    Expect metarw#is_preparing_to_edit() to_be_false
    Expect getline(1, '$') ==# ['']

    edit func:F()

    Expect metarw#is_preparing_to_edit() to_be_false
    Expect getline(1, '$') ==# ['1']
  end

  it 'returns false while :read'
    Expect metarw#is_preparing_to_edit() to_be_false
    Expect getline(1, '$') ==# ['']

    read func:['read',F()]

    Expect metarw#is_preparing_to_edit() to_be_false
    Expect getline(1, '$') ==# ['read', '0']
  end

  it 'returns false while :write'
    Expect metarw#is_preparing_to_edit() to_be_false
    Expect getline(1, '$') ==# ['']

    write func:execute('put=[''write'',F()]')

    Expect metarw#is_preparing_to_edit() to_be_false
    Expect getline(1, '$') ==# ['', 'write', '0']
  end
end
