#=move.jl - Updates the game file with a move, accepts 1 command line argument,<filename> => database
=#

module move

  include("dParse.jl")
  using dParse
  using ST
  using SQLite

  #=----Parses the database and determines where pieces are on the board----=#

  #= ---- Opens the Database for reading ---- =#
  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile

  #= ---- Determines whos turn it is (white or black) ---- =#

  res = SQLite.query(db,"SELECT MAX(move_number) FROM moves;") #Finds the last played move (maximum move_number)
  lastMoveIDNullable = res[1,1] #SQL query with max move_number (POSSIBLY "NULL" if no moves have been made)

  if (!isnull(lastMoveIDNullable)) #Checks that lastMoveID was not NULL
    lastMoveID = get(res[1,1]) #Parses the last move move_number as an Int

  else #lastMoveID is NULL
    lastMoveID = 0 #move_number "0" is unsused. This implies no moves have been made

  end

  #=---- Determines a move to make (AI integration below)----=#
  move_number = lastMoveID+1 #The current move is move#: move_number


  #Todo: write AI: must define variables: move_type, sourcex, sourcey, targetx, targety, option, i_am_cheating

  # get all of our pieces on board set numbers to them  ####if piece is our piece its choosable

  create array

  # check every square if empty square dont add to list, if piece colour = opponent dont add, if ours add

  if piece colour = our colour add to list
  create temppiece

  # choose random piece from list based on random number from list (rand mod listend)

  find array length
  do temppiece = rand % arraylength

  # set temp piece to it
  # use validate file to see what moves it can make, number them, put them in a list  ####movevalidate

  create another array, if piece -> target = movevalidate, add to list,

  # make a move based on random number from list (rand mod listend)

  makemove = rand % array2length

 #random number part
 #use random function mod max val it can be








  # ---- Saves the determined move in the database ---- =#
  SQLite.query(db,"INSERT INTO moves (move_number, move_type, sourcex, sourcey, targetx, targety, option, i_am_cheating)
  VALUES ($(move_number),$(move_type),$sourcex, $sourcey,$targetx, $targety, $option, $(i_am_cheating));")

end
