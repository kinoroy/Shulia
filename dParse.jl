module dParse
include("square.jl")
using ST
global DB

db = SQLite.DB(pathToDatabase) #Opens the database gamefile
res = SQLite.query(db,"SELECT key,value FROM meta where key = type;")
gameType = get(res[1,2])


if gameType == "standard"
  board = fill!(Array(square,9,9),square())
  board[1,5] = square('k','w')
  board[9,5] = square('k','b')
  board[1,[4,6]] = square('g','w')
  board[9,[4,6]] = square('g','b')
  board[1,[3,7]] = square('s','w')
  board[9,[3,7]] = square('s','b')
  board[1,[2,8]] = square('n','w')
  board[9,[2,8]] = square('n','b')
  board[1,[1,9]] = square('l','w')
  board[9,[1,9]] = square('l','b')
  board[2,2] = square('b','w')
  board[8,8] = square('b','b')
  board[2,8] = square('r','w')
  board[8,2] = square('r','b')
  board[3,1:9] = square('p','w')
  board[7,1:9] = square('p','b')


  else

  board = fill!(Array(square,5,5),square())
  board[1,1] = square('k','w')
  board[5,5] = square('k','b')
  board[1,2] = square('g','w')
  board[5,4] = square('g','b')
  board[1,3] = square('s','w')
  board[5,3] = square('s','b')
  board[1,4] = square('b','w')
  board[5,2] = square('b','b')
  board[1,5] = square('r','w')
  board[5,1] = square('r','b')
  board[2,1] = square('p','w')
  board[4,5] = square('p','b')
end
ST.saveBoard(board)

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
        board[targetx][targety].piece = option
        if iseven(currentMoveID)
          board[targetx][targety].team = 'w'
        else
          board[targetx][targety].team = 'b'
        end
      elseif move_type == "resign"
        #Do nothing
      end

    end

  ST.saveBoard(board)
  return board
end #End function


#End module
end
