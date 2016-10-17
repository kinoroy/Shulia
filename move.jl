#=move.jl - Updates the game file with a move, accepts 1 command line argument,<filename> => database
=#

module move

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  SQLite.connect(database) #Opens the database gamefile

end
