#=move_user_drop.jl - > drops the piece at the coordinates
given. accepts 4 command line argument,<filename> => database <piece> => piece
<xtarget> => xTarget <ytarget> => yTarget
=#
#include("square.jl")
include("dParse.jl")

module move_user_drop
#using ST
using SQLite
function drop(database,pieceToDrop,xTarget,yTarget)
  #database = ARGS[1] #/path/to/database/file {string}
  #pieceToDrop = chomp(ARGS[2])[1] #piece {char}
  #xTarget = parse(Int,chomp(ARGS[3])) #x coordinate to place piece {Int}
  #yTarget = parse(Int,chomp(ARGS[4])) #y coordinate to place piece {Int}
  board = ST.loadBoard()
  db = SQLite.DB(database) #Opens the database gamefile

    #= ---- Determines the move_number ---- =#

    res = SQLite.query(db,"""SELECT MAX("move_number") FROM moves;""") #Finds the last played move (maximum move_number)
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
    VALUES ($(move_number),'drop',$xTarget, $yTarget, '$pieceToDrop');")
    board[xTarget,yTarget].piece = pieceToDrop
    if iseven(move_number)
      board[xTarget,yTarget].team = 'w'
    else
      board[xTarget,yTarget].team = 'b'
    end

  ST.saveBoard(board)
end
end
