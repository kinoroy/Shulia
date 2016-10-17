#=move_cheat.jl - Updates the game file with a move with possible cheating,
accepts 1 command line argument,<filename> => database
=#

module move_cheat

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  SQLite.connect(database) #Opens the database gamefile

end
