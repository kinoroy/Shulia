#=win.jl - replay the game fromstart to finish, at every step checking if the game
is won. If the game is won, print ”B” for Black winning, and ”W” for white winning. If black resigned,
print ”R”. If white resigned, print ”r”. If the game is on, print ”?”. If the game is a draw, print
”D”.
Accepts 1 command line argument,<filename> => database
=#

module win

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database)  #Opens the database gamefile

end
