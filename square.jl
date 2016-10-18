module ST

type square
  piece::Char
  team::Char
  function square() #Empty constructor
    new('x','x') #(x,x) is EMPTY
  end
  function square(n,t) #Specific constructor
    new(n,t)
  end

end

  function clear() #This function clears the square to be empty
    piece = 'x'
    team = 'x'
  end
  #=----The following are tester functions, they are bool return functions meant to be used with find()
  Example:  to find all kings on a board you could run "find(k,board)"
  Each function is named the same as the piece it checks for
  There is also an "isPromoted" function to determine if the piece is promoted=#
  function b(test)
    if test.team == 'b'
      return true
    else
      return false
    end
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
  function b(test)
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

export square, clear,w,b,p,l,b,s,g,n,r,k,isPromoted
end
