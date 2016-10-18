module square

type square
  piece::Char
  team::Char
  function square()
    new('x','x') #(x,x) is EMPTY
  end
  function square(n,t)
    new(n,t)
  end
  function clear()
    piece = 'x'
    team = 'x'
  end
end

end
