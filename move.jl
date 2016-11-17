#=move.jl - Updates the game file with a move, accepts 1 command line argument,<filename> => database
=#
include("AI.jl")
include("dParse.jl")
module move
using dParse
using BM
using AI
using SQLite

  #=----Parses the database and determines where pieces are on the board----=#

  #= ---- Opens the Database for reading ---- =#
  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile

  (board,gameType,seed,lastMoveID) = dParse.Parse(database)

  AI.init(gameType,board,seed)

  (sourcex,sourcey,targetx,targety) = AI.get_play()
  move_number = lastMoveID+1
  move_type = "move"
  SQLite.query(db,"""INSERT INTO moves (move_number, move_type, sourcex, sourcey, targetx, targety, i_am_cheating)
  VALUES ("$(move_number)","$(move_type)","$sourcex","$sourcey","$targetx","$targety", "false")""";)

end
