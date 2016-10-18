#=validate.jl - replay the game from start to the current move, at every step making
sure that the rules were kept. Print 0 is the game was played cleanly so far and the move ID
of the violating move if it wasn’t. Accepts 1 command line argument,<filename> => database
=#

module validate

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile

end
