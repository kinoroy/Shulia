#=move_user_move.jl > moves the piece at the source into the target area. If promote
is equal to ”T” then promote the piece after it has completed the move.
Accepts 6 command line args : <filename> => database, <xsource> => xSource
<ysource> => ySource <xtarget> =>xTarget <ytarget> =>yTarget <promote> => promote
=#
include("square.jl")
include("dParse.jl")
module move_user_move

  using ST
  using SQLite
  board = ST.loadBoard()
  database = ARGS[1] #/path/to/database/file {string}
  xSource = parse(chomp(ARGS[2]),Int) #x coordinate of piece {Int}
  ySource = parse(chomp(ARGS[3]),Int) #y coordinate of piece {Int}
  xTarget = parse(chomp(ARGS[4]),Int) #x coordinate to place piece {Int}
  yTarget = parse(chomp(ARGS[5]),Int) #y coordinate to place piece {Int}
  promoteDict = Dict("T" => true, "F" => false)
  shouldPromote = promoteDict[ARGS[6]] #Promote the piece after moving {bool}
  db = SQLite.DB(database) #Opens the database gamefile

    #= ---- Determines the move_number ---- =#

    res = SQLite.query(db,"SELECT MAX(move_number) FROM moves;") #Finds the last played move (maximum move_number)
    lastMoveIDNullable = res[1,1] #SQL query with max move_number (POSSIBLY "NULL" if no moves have been made)

    if (!isnull(lastMoveIDNullable)) #Checks that lastMoveID was not NULL
      lastMoveID = get(res[1,1]) #Parses the last move move_number as an Int

    else #lastMoveID is NULL
      lastMoveID = 0 #move_number "0" is unsused. This implies no moves have been made

    end
    move_number = lastMoveID+1 #Current move number

  #=-----UPDATE DATABASE & BOARD W/MOVE-----=#
  if shouldPromote #Option will be '!'
    SQLite.query(db,"INSERT INTO moves (move_number, move_type, sourcex, sourcey, targetx, targety, option)
    VALUES ($(move_number),move,$xSource, $ySource,$xTarget, $yTarget, !);")
    board[targetx][targety].piece = board[sourcex][sourcey].piece #Updates the board before next move
    board[targetx][targety].team = board[sourcex][sourcey].team
    clear!(board[sourcex][sourcey])
    promote!(board[targetx][targety])
  else #Option will be NULL
    SQLite.query(db,"INSERT INTO moves (move_number, move_type, sourcex, sourcey, targetx, targety)
    VALUES ($(move_number),move,$xSource, $ySource,$xTarget, $yTarget);")
    board[targetx][targety].piece = board[sourcex][sourcey].piece #Updates the board before next move
    board[targetx][targety].team = board[sourcex][sourcey].team
    clear!(board[sourcex][sourcey])
  end
ST.saveBoard(board)
end
