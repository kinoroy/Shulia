#=move_user_resign.jl - the current user resigns, accepts 1 command line argument,<filename> => database
=#

module move_user_resign

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  db =  SQLite.DB(database) #Opens the database gamefile

  #= ---- Determines the move_number ---- =#

  res = SQLite.query(db,"""SELECT MAX("move_number") FROM moves;""") #Finds the last played move (maximum move_number)
  lastMoveIDNullable = res[1,1] #SQL query with max move_number (POSSIBLY "NULL" if no moves have been made)

  if (!isnull(lastMoveIDNullable)) #Checks that lastMoveID was not NULL
    lastMoveID = get(res[1,1]) #Parses the last move move_number as an Int

  else #lastMoveID is NULL
    lastMoveID = 0 #move_number "0" is unsused. This implies no moves have been made

  end
  move_number = lastMoveID+1 #Current move number

  #=-----UPDATE DATABASE W/MOVE-----=#
  #Option will be dropped pieces abv
    SQLite.query(db,"INSERT INTO moves (move_number, move_type)
    VALUES ($(move_number),'resign');")

end
