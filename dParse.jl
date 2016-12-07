include("board.jl")
module dParse

using BM
global DB
using SQLite


function Parse(pathToDatabase)

  #captures = readdml("captures.txt")
  db = SQLite.DB(pathToDatabase) #Opens the database gamefile
  #calculates all black piece positions
  res = SQLite.query(db,"SELECT key,value FROM meta where key = 'type';")
  global gameType = get(res[1,2])
  res = SQLite.query(db,"SELECT key,value FROM meta where key = 'seed';")
  global seed = parse(get(res[1,2]))
board = BM.startGame(gameType)
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
        if ( (targetx,targety) in keys(board))# Non-empty piece at target: capture
          #push(captures,board[targetx][targety])
        end

        board = BM.nextState(board,(sourcex,sourcey,targetx,targety))

      elseif move_type == "drop"
        option = get(optionNullable)
        try
          #deleteat!(captures,findfirst(x->x.piece==option))
        end
        targetx = get(targetxNullable)
        targety = get(targetyNullable)
        board[targetx][targety].piece = option
        if iseven(currentMoveID)
         board[(targetx,targety)] = (option,'w')
        else
          board[(targetx,targety)] = (option,'b')
        end
        newBoard.currentPlayer = (newBoard.currentPlayer == 'b' ? 'w' : 'b')
      elseif move_type == "resign"
        #Do nothing
      end

    end

  return (board,gameType,seed,lastMoveID)
end #End function


#End module
end
