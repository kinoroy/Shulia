#=move_user_drop.jl - > drops the piece at the coordinates
given. accepts 4 command line argument,<filename> => database <piece> => piece
<xtarget> => xTarget <ytarget> => yTarget
=#

module move_user_drop

include("square.jl")
using ST
using SQLite

database = ARGS[1] #/path/to/database/file {string}
pieceToDrop = parse(chomp(ARGS[2]),Int) #piece {char}
xTarget = parse(chomp(ARGS[3]),Int) #x coordinate to place piece {Int}
yTarget = parse(chomp(ARGS[4]),Int) #y coordinate to place piece {Int}

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

#=-----UPDATE DATABASE W/MOVE-----=#
#Option will be dropped pieces abv
  SQLite.query(db,"INSERT INTO moves (move_number, move_type, targetx, targety, option)
  VALUES ($(move_number),drop,$xTarget, $yTarget, $pieceToDrop);")


board = readdlm("board.txt") #reads board
#Updates the board (should check that move was successful before doing this)
which = pieceToDrop #what kind of piece is being moved
if iseven(move_number)
  who = 'w'
else
  who = 'b'
end


board[xTarget,yTarget] = square(which,who) #Places the piece at new location


writedlm("board.txt",board) #writes the board to memory
end
