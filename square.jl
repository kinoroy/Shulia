module ST

type square
  piece::Char
  team::Char
  function square() #Empty constructor
    new('_','_') #(x,x) is EMPTY
  end
  function square(n,t) #Specific constructor
    new(n,t)
  end

end
  function saveBoard(target)
    pieceArr = Array(Char,9,9)
    teamArr = Array(Char,9,9)
    for i in eachindex(target)
      pieceArr[i]=target[i].piece
      teamArr[i]=target[i].team
    end
    writedlm("boardA.txt",pieceArr)
    writedlm("boardB.txt",teamArr)
  end
  function loadBoard()
    pieceArr = readdlm("boardA.txt")
    teamArr = readdlm("boardB.txt")
    board = Array(square,9,9)
    for i in eachindex(board)
      board[i]=square(pieceArr[i][1],teamArr[i][1])
    end
    return board
  end
  function clear!(target) #This function clears the square to be empty
    target.piece = '_'
    target.team = '_'
  end
  function promote!(target)
    target.piece = uppercase(target.piece) #promotes the piece
  end
  #=----The following are tester functions, they are bool return functions meant to be used with find()
  Example:  to find all kings on a board you could run "find(k,board)"
  Each function is named the same as the piece it checks for
  There is also an "isPromoted" function to determine if the piece is promoted=#
  function isEmpty(test)
    if test.piece == '_'
      return true
    else
      return false
    end
  end

  function b(test)
    return test.team == 'b'
  end
  function w(test)
    if test.team == 'w'
      return true
    else
      return false
    end
  end
  function k(test)
    if test.piece == 'k' || test.piece == 'K'
      return true
    else
      return false
    end
  end
  function n(test)
    if test.piece == 'n' || test.piece == 'N'
      return true
    else
      return false
    end
  end
  function r(test)
    if test.piece == 'k' || test.piece == 'K'
      return true
    else
      return false
    end
  end
  function g(test)
    if test.piece == 'k' || test.piece == 'K'
      return true
    else
      return false
    end
  end
    function s(test)
      if test.piece == 's' || test.piece == 'S'
        return true
      else
        return false
      end
    end
  function bi(test)
    if test.piece == 'b' || test.piece == 'B'
      return true
    else
      return false
    end
  end
  function l(test)
    if test.piece == 'l' || test.piece == 'L'
      return true
    else
      return false
    end
  end
    function p(test)
      if test.piece == 'p' || test.piece == 'P'
        return true
      else
        return false
      end
    end
    function isPromoted(test)
      if test.piece == uppercase(test.piece)
        return true
      else
        return false
      end
    end

export isEmpty,square,loadBoard,saveBoard, clear!,promote!,w,b,p,l,bi,s,g,n,r,k,isPromoted
end
