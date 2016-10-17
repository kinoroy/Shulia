#=move_user_move.jl > moves the piece at the source into the target area. If promote
is equal to ”T” then promote the piece after it has completed the move.
Accepts 6 command line args : <filename> => database, <xsource> => xSource
<ysource> => ySource <xtarget> =>xTarget <ytarget> =>yTarget <promote> => promote
=#

module move_user_move

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  xSource = parse(chomp(ARGS[2]),Int) #x coordinate of piece {Int}
  ySource = parse(chomp(ARGS[3]),Int) #y coordinate of piece {Int}
  xTarget = parse(chomp(ARGS[4]),Int) #x coordinate to place piece {Int}
  yTarget = parse(chomp(ARGS[5]),Int) #y coordinate to place piece {Int}
  promoteDict = Dict("T" => true, "F" => false)
  promote = promoteDict[ARGS[6]] #Promote the piece after moving {bool}

  SQLite.connect(database) #Opens the database gamefile

end
