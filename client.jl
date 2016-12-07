include("start.jl")
include("move_user_move.jl")


#=client.jl - Auth: Kino Roy for Shogi, an assignment for CMPT276:
connects to a server to play a game =#
module networking
using start
using move_user_move


function getAt(arr, index,backup)
  local res
  try
    res = arr[index]
  catch err
    res = backup

  return res
end
end

function clientStart(idatabase,gameType,cheating,timeLimit,limitAdd,sente_time,gote_time)
  global connection = connect(8080)
  global database = idatabase
  startShogi(database,gameType,cheating,timeLimit,limitAdd,sente_time,gote_time)
  play(gameType,cheating,timeLimit,limitAdd)
end

function clientClose()
  global connection
  close(connection)
end

function play(gameType,cheating,timeLimit,limitAdd)
  global connection
  write(connection,"0:$gameType:$cheating:$timeLimit:$limitAdd")

  while true
    message = chomp(readline(connection))
    sL = split(message,r":",keep=false)
    wincode = getAt(sL,1,-1)

   if wincode == "0"
      #I"m player 1
        global authString = getAt(sL,2,-1)[1]
    elseif wincode == "1"
      #I"m player 2
        global authString = getAt(sL,2,-1)[1]
    elseif wincode == "2"
      #Server quits
      println("gameover:server quit")
    elseif wincode == "3"
      #There"s a draw
      println("gameover:draw")
    elseif wincode == "8"
      #Not your turn
      println("wait")
    elseif wincode == "9"
      #This is your opponents move, it's now your turn
      #Prompt user to make move (GUI)
      #!!!!!! SAMPLE DATA!!!!!!!!!!!!!!!:
      database="game1.db"
      sourcex=1
      soucey=1
      targetx=1
      targety=1
      promote = false

      move_user_move.moveUserMove(database,sourcex,sourcey,targetx,targety,promote::Bool)
      write(connection,"2:$sourcex:$sourcey:$targetx:$targety")
    elseif wincode == "10"
      #bad payload
    elseif wincode == "e"
  end
end
end

end
