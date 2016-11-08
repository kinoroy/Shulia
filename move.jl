#=move.jl - Updates the game file with a move, accepts 1 command line argument,<filename> => database
=#

  include("dParse.jl")
  include("AIHelp.jl")
module move
using ST
  using dParse

  using SQLite
using Tree
  #=----Parses the database and determines where pieces are on the board----=#

  #= ---- Opens the Database for reading ---- =#
  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile

  #= ---- Determines whos turn it is (white or black) ---- =#

  res = SQLite.query(db, """SELECT max("move_number") from moves;""") #Finds the last played move (maximum move_number)
  lastMoveIDNullable = res[1,1] #SQL query with max move_number (POSSIBLY "NULL" if no moves have been made)

  if (!isnull(lastMoveIDNullable)) #Checks that lastMoveID was not NULL
    lastMoveID = get(res[1,1])#Parses the last move move_number as an Int

  else #lastMoveID is NULL
    lastMoveID = 0 #move_number "0" is unsused. This implies no moves have been made

  end

  #=---- Determines a move to make (AI integration below)----=#
  move_number = lastMoveID+1 #The current move is move#: move_number
  if (iseven(move_number))
    currentPlayer = 'w'
  else
    currentPlayer = 'b'
  end



  # ---- Saves the determined move in the database ---- =#
  SQLite.query(db,"INSERT INTO moves (move_number, move_type)
  VALUES ($(move_number),'resign');")
#=
  SQLite.query(db,"""INSERT INTO moves (move_number, move_type, sourcex, sourcey, targetx, targety, option, i_am_cheating)
  VALUES ("$(move_number)","$(move_type)","$sourcex","$sourcey","$targetx","$targety", "$option", "$(i_am_cheating)")""";)
=#

  function randomUnit(moveNumber)
    if (even(moveNumber) == true)
      team = "w"
    else
      team = "b"
    end

    for x in 1:9
      for y in 1:9
        if (isEmpty(board[x][y]) == false) && (board[x][y].team == team)
          unit = board[x][y].piece
          return unit
      end
    end
  end

  function randomMove(unit, sourcex, sourcey,moveNumber)
    for x in 4:9
      for y in 1:9
        if ( moveValidate(unit, "move", board[sourcex][sourcey].team, sourcex, sourcey, x, y) == true)
          move = "move"
          SQLite.query(db,"INSERT INTO moves (move_number, move_type, sourcex, sourcey, targetx, targety)
          VALUES ($(moveNumber),$move,$sourcex, $sourcey,$x, $y;")
        end
      end
    end
  end


end
