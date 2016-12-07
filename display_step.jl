#=display.jl - will replay the game
from start to finish, displaying the current game state.
Accepts 1 command line argument,<filename> => database
=#
#include("square.jl")
include("dParse.jl")
include("board.jl")
using BM

#include("start.jl")
using SQLite
pathToDatabase = ARGS[1]
db = SQLite.DB(pathToDatabase) #Opens the database gamefile
#global board = ST.loadBoard()
#calculates all black piece positions
res = SQLite.query(db,"""SELECT "value" FROM meta WHERE "key" = 'type';""")
gameType = get(res[1,1])
#=----Gets last move number----=#
res = SQLite.query(db,"""SELECT MAX("move_number") FROM moves;""") #Finds the last played move (maximum move_number)
lastMoveIDNullable = res[1,1] #SQL query with max move_number (POSSIBLY "NULL" if no moves have been made)

if (!isnull(lastMoveIDNullable)) #Checks that lastMoveID was not NULL
lastMoveID = get(res[1,1]) #Parses the last move move_number as an Int

else #lastMoveID is NULL
lastMoveID = 0 #move_number "0" is unsused. This implies no moves have been made

end
currentMoveID=1


#=Helper functions=#
function displaymini()
  board = BM.startGame(gameType)
  global dboard = Array(Char,9,9)
  for (x,y) in keys(board)
    dboard[(x,y)]=board[(x,y)][1]
  end

  for x_index in (1:11)
    for y_index in (1:11)
      if y_index==1
        if x_index==1
          print("┌")
        elseif x_index==11
          print("└")
        elseif rem(x_index,2)==0
          print("|")
        else
          print("├")
        end
      elseif y_index==11
        if x_index==1
          print("┐")
        elseif x_index==11
          print("┘")
        elseif rem(x_index,2)==0
          print("|")
        else
          print("┤")
        end
      elseif rem(y_index,2)==1
        if x_index==1
          print("┬")
        elseif x_index==11
          print("┴")
        elseif rem(x_index,2)==1
          print("┼")
        else
          print("|")
        end
      else
        if rem(x_index,2)==1
          print("-")
        else
          if dboard[(div(x_index,2),(6-div(y_index,2)))]=='k' || dboard[(div(x_index,2),(6-div(y_index,2)))]=='K'
            print_with_color(:yellow, "$(dboard[div(x_index,2),(6-div(y_index,2))])")
            continue
          end
          print(dboard[(div(x_index,2),(6-div(y_index,2)))])
        end
      end
    end
    print("\n")
  end
end



function displaystandard()

  board = BM.startGame(gameType)
  global dboard = Array(Char,9,9)
  for (x,y) in keys(board)
    dboard[(x,y)]=board[(x,y)][1]
  end

for x_index in (1:19)
  for y_index in (1:19)
    if y_index==1
      if x_index==1
        print("┌")
      elseif x_index==19
        print("└")
      elseif rem(x_index,2)==0
        print("|")
      else
        print("├")
      end
    elseif y_index==19
      if x_index==1
        print("┐")
      elseif x_index==19
        print("┘")
      elseif rem(x_index,2)==0
        print("|")
      else
        print("┤")
      end
    elseif rem(y_index,2)==1
      if x_index==1
        print("┬")
      elseif x_index==19
        print("┴")
      elseif rem(x_index,2)==1
        print("┼")
      else
        print("|")
      end
    else
      if rem(x_index,2)==1
        print("-")
      else
        if dboard[(div(x_index,2),(10-div(y_index,2)))]=='k' || dboard[(div(x_index,2),(10-div(y_index,2)))]=='K'
          print_with_color(:yellow, "$(dboard[(div(x_index,2),(10-div(y_index,2)))])")
          continue
        end
        print(dboard[(div(x_index,2),(10-div(y_index,2)))])
      end
    end
  end
  print("\n")
end

function Setupboard()
  res = SQLite.query(db,"""SELECT sourcex,sourcey,targetx,targety,move_type,option FROM moves WHERE "move_number" = $(currentMoveID);""")
  sourcexNullable = res[1,1]
  sourceyNullable = res[1,2]
  targetxNullable = res[1,3]
  targetyNullable = res[1,4]
  targetx = get(targetxNullable)
  targety = get(targetyNullable)
  sourcex = get(sourcexNullable)
  sourcey = get(sourceyNullable)
  board[targetx,targety].piece = board[sourcex,sourcey].piece
  board[targetx,targety].team = board[sourcex,sourcey].team
  ST.clear!(board[sourcex,sourcey])
  ST.saveBoard(board)
end

end#Func
#=----=#
#=----Replays the game until move_id = lastMoveID----=#
while currentMoveID<=lastMoveID
  global board
  res = SQLite.query(db,"""SELECT sourcex,sourcey,targetx,targety,move_type,option FROM moves WHERE "move_number" = $(currentMoveID);""")
  sourcexNullable = res[1,1]
  sourceyNullable = res[1,2]
  targetxNullable = res[1,3]
  targetyNullable = res[1,4]
  move_type = get(res[1,5])
  optionNullable = res[1,6]

  if move_type == "move" #Regular Move
    targetx = get(targetxNullable)
    targety = get(targetyNullable)
    sourcex = get(sourcexNullable)
    sourcey = get(sourceyNullable)
    if !(ST.isEmpty(board[targetx,targety]))# capture
      #push(captures,board[targetx][targety])
    end
    board[targetx,targety].piece = board[sourcex,sourcey].piece
    board[targetx,targety].team = board[sourcex,sourcey].team
    ST.clear!(board[sourcex,sourcey])

  elseif move_type == "drop"
    option = get(optionNullable)
    try
      #deleteat!(captures,findfirst(x->x.piece==option))
    end
    targetx = get(targetxNullable)
    targety = get(targetyNullable)
    board[targetx,targety].piece = board[sourcex,sourcey].piece
    board[targetx,targety].team = board[sourcex,sourcey].team
  elseif move_type == "resign"
    #Do nothing
  end
  ST.saveBoard(board)

  if gameType == "standard"
    displaystandard()
  else
    displaymini()
  end
  sleep(1) #Waits half a second before running displaying a new board
  currentMoveID+=1
end

println("Enter b to go backward, or enter f to go forward\nTo exit viewing the display, enter quit")

instruction=readline(STDIN)

function backward()#function to go backward
  currentMoveID-=1
  if currentMoveID<1
    println("This is the first move")
    continue
  end
  Setupboard()
end

while instruction!="quit\n"
  global board
  if instruction=="b\n"
    currentMoveID-=1
    if currentMoveID<1
      println("This is the first move")
      continue
    end
    #Set up the team and piece of the board#
    Setupboard()
    if gameType == "standard"
      displaystandard()
    else
      displaymini()
    end
    sleep(1)
  elseif instruction=="f\n"
    currentMoveID+=1
    if currentMoveID>lastMoveID
      println("Exceed the last move")
      continue
    end
    Setupboard()
    if gameType == "standard"
      displaystandard()
    else
      displaymini()
    end
    sleep(1)
  end
  instruction=readline(STDIN)
end
export backward, Setupboard
