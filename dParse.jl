module dParse
include("square.jl")
using ST
global DB
startingPositionBlack = [[9,5],[9,4],[9,6],[9,3],[9,7],[9,2],[9,8],[9,1],[9,9],
[8,8],[8,2],[7,1],[7,2],[7,3],[7,4],[7,5],[7,6],[7,7],[7,8],[7,9]]
startingPositionWhite = [[1,5],[1,4],[1,6],[1,3],[1,7],[1,2],[1,8],[1,1],[1,9],
[2,2],[2,8],[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],[3,7],[3,8],[3,9]] #startingPosition of all the pieces in Shogi
board = fill!(Array(square,9,9),square())
pieces = ["k","g1","g2","s1","s2","n1","n2","l1","l2","b","r",
"p1","p2","p3","p4","p5","p6","p7","p8"] #in order relative to startingPosition array

function dParse(pathToDatabase)
  board = ST.loadBoard()
  #captures = readdml("captures.txt")
  db = SQLite.DB(pathToDatabase) #Opens the database gamefile
  #calculates all black piece positions

#=----Gets last move number----=#
res = SQLite.query(db,"SELECT MAX(move_number) FROM moves;") #Finds the last played move (maximum move_number)
lastMoveIDNullable = res[1,1] #SQL query with max move_number (POSSIBLY "NULL" if no moves have been made)

if (!isnull(lastMoveIDNullable)) #Checks that lastMoveID was not NULL
  lastMoveID = get(res[1,1]) #Parses the last move move_number as an Int

else #lastMoveID is NULL
  lastMoveID = 0 #move_number "0" is unsused. This implies no moves have been made

end
currentMoveID=1
  #=----Replays the game until move_id = lastMoveID----=#
  while currentMoveID<=lastMoveID
    res = SQLite.query(db,"SELECT sourcex,sourcey,targetx,targety,move_type,option FROM moves WHERE move_id = $(currentMoveID);")
    sourcexNullable = res[1][1]
    sourceyNullable = res[1][2]
    targetxNullable = res[1][3]
    targetyNullable = res[1][4]
    move_type = get(res[1][5])
    optionNullable = res[1][6]

    if move_type == "move" #Regular Move
      targetx = get(targetxNullable)
      targety = get(targetyNullable)
      sourcex = get(sourcexNullable)
      sourcey = get(sourceyNullable)
      if !(isEmpty(board[targetx][targety]))# capture
        #push(captures,board[targetx][targety])
      end
      board[targetx][targety].piece = board[sourcex][sourcey].piece
      board[targetx][targety].team = board[sourcex][sourcey].team
      clear!(board[sourcex][sourcey])

    elseif move_type == "drop"
      option = get(optionNullable)
      try
        #deleteat!(captures,findfirst(x->x.piece==option))
      end
      targetx = get(targetxNullable)
      targety = get(targetyNullable)
      board[targetx][targety].piece = board[sourcex][sourcey].piece
      board[targetx][targety].team = board[sourcex][sourcey].team
    elseif move_type == "resign"
      #Do nothing
    end


  end

ST.saveBoard(board)
return board
#End function
end
#End module
end
