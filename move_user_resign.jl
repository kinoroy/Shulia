#=move_user_resign.jl - the current user resigns, accepts 1 command line argument,<filename> => database
=#

module move_user_resign

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  SQLite.connect(database) #Opens the database gamefile

end
