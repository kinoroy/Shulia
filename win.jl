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

  maxMove = SQLite.query(db, "SELECT max(move_number)")
  for x in 1:maxMove  #iterates through each row of the database
    dataMove = SQLite.query(db, "SELECT move_number, move_type, targetx, targety FROM moves WHERE move_number = $x")
    move_type = dataMove[1][2]
    targetx = dataMove[1][3]
    targety = dataMove[1][4]

    #Case 1: Resigned
    if move_type == "resign"
      if even(x) == true
        println("r")
      else #x is odd
        println("R")
      end

    #Case 2: Win
    #Game is won on the move that captures a king
    #I implemented win where, if the target X Y location of the current move is a king, it means the king is captpured so the other team wins
    elseif ( k(board[targetx][targety]) == true) #uses function from spuare.jl
      if (board[targetx][targety].team == "b")
        println("W")
      else #board[targetx][targety].team == "w"
        println("B")
      end

    elseif #draw MISSING
    #draw chance is small so ignore for now

    else #game is on
      println("?")
    end
  end

  #=Return true if victim is vulnerable to opponent
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
  =#

end
