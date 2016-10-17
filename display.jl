#=display.jl - will replay the game
from start to finish, displaying the current game state.
Accepts 1 command line argument,<filename> => database
=#

module display

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  SQLite.connect(database) #Opens the database gamefile

end
