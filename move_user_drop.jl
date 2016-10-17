#=move_user_drop.jl - > drops the piece at the coordinates
given. accepts 4 command line argument,<filename> => database <piece> => piece
<xtarget> => xTarget <ytarget> => yTarget
=#

module move_user_drop

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  piece = ARGS[2] #one of {b,g,k,l,n,p,r,s} {String}
  xTarget = parse(chomp(ARGS[3]),Int) #x coordinate to place piece {Int}
  yTarget = parse(chomp(ARGS[4]),Int) #x coordinate to place piece {Int}
  
  SQLite.connect(database) #Opens the database gamefile

end
