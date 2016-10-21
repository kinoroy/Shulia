#=win.jl - replay the game fromstart to finish, at every step checking if the game
is won. If the game is won, print ”B” for Black winning, and ”W” for white winning. If black resigned,
print ”R”. If white resigned, print ”r”. If the game is on, print ”?”. If the game is a draw, print
”D”.
Accepts 1 command line argument,<filename> => database
=#

module win

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database)  #Opens the database gamefile

  #pseudocode
  for moves in database
    if isCheckMate() == "b"
      println("B")
    elseif isCheckMate() =="w"
      println("W")
    elseif isResigned() == "b"
      println("B")
    elseif isResigned() == "w"
      println("r")
    elseif isDraw() == true
      println("D")
    else
      println("?")
    end
  end

  #Return true if victim is vulnerable to opponent
  function isThreatened(victim)
    for piece in opponent
      if (piece.dead == false)
        if (moveValidate(piece, piece.team, piece.x, piece.y, victim.x, victim.y) == true)
          return true
        end
      end
    end
    return false
  end

  #Checks for checkmate
  function isCheckMate()
    if (isThreatened(bKing) == true)
      if (blockKing() == false)
        if (moveKing() == false)
          return "b"
        end
      end
    end
    if (isThreatened(wKing) == true)
      if (blockKing() == false)
        if (moveKing() == false)
          return "w"
        end
      end
    end
    return "x"
  end

  #Checks for resigned
  function isResigned(database)
    if database.move_number == 0
      return false
    end
    if even(database.move_number) == true
      if database.movetype == "resign"
        return "w"
      end
    else
      if database.movetype == "resign"
        return "b"
      end
    end
    return "x"
  end    

  #looks for a piece to block for the king
  function blockKing()
  end

  #If blockKing == false, looks for an unthreatened area
  function moveKing()
  end
end
