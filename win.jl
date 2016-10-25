#=win.jl - replay the game fromstart to finish, at every step checking if the game
is won. If the game is won, print ”B” for Black winning, and ”W” for white winning. If black resigned,
print ”R”. If white resigned, print ”r”. If the game is on, print ”?”. If the game is a draw, print
”D”.
Accepts 1 command line argument,<filename> => database
=#
include("square.jl")
include("dParse.jl")
module win
using ST
  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database)  #Opens the database gamefile
  board = ST.loadBoard()
res = "?"
  maxMove = get(SQLite.query(db, """SELECT max("move_number") from moves;""")[1,1])
  for x in 1:maxMove  #iterates through each row of the database
    dataMove = SQLite.query(db, """SELECT move_number, move_type, targetx, targety,sourcex,sourcey FROM moves WHERE "move_number" = $x""")
    move_type = get(dataMove[1,2])
    targetx = get(dataMove[1,3])
    targety = get(dataMove[1,4])

    #Case 1: Resigned
    if move_type == "resign"
      if even(x) == true
        res="r"
      else #x is odd
        res="R"
      end

    #Case 2: Win
    #Game is won on the move that captures a king
    #I implemented win where, if the target X Y location of the current move is a king, it means the king is captpured so the other team wins
    elseif ( k(board[targetx,targety]) == true) #uses function from spuare.jl
      if (board[targetx,targety].team == "b")
        res = "W"
      else #board[targetx][targety].team == "w"
        res = "B"
      end
    end
    if !(isnull(dataMove[1,5])) #type:move
	    sourcex=get(dataMove[1,5])
	    sourcey=get(dataMove[1,6])
	    board[targetx,targety].piece = board[sourcex,sourcey].piece #Updates the board before next move
	    board[targetx,targety].team = board[sourcex,sourcey].team
	    ST.clear!(board[sourcex,sourcey])
    end
  end

println(res)
end
