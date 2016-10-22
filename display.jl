#=display.jl - will replay the game
from start to finish, displaying the current game state.
Accepts 1 command line argument,<filename> => database
=#

module display
using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile
#print_with_color(:green, "king")
game = Array(Float64,9,9)
Bishop=98 #letter b
Gold_General=103 #letter g
King=107 #letter k
Lance=108 #letter l
Knight=110 #letter n
Pawn=112 #letter p
Rook=114 #letter r
Silver_General=115 #letter s
promoted_Bishop=66 #letter B
promoted_Gold_General=71 #letter G
promoted_King=75 #letter K
promoted_Lance=76 #letter L
promoted_Knight=78 #letter N
promoted_Pawn=80 #letter P
promoted_Rook=82 #letter R
promoted_Silver_General=83 #letter S
for x_target in (1:9)
  for y_target in (1:9)
    if board[x_target,y_target]=="b"
      game[x_target,y_target]=Bishop
    elseif board[x_target,y_target]=="g"
      game[x_target,y_target]=Gold_General
    elseif board[x_target,y_target]=="k"
      game[x_target,y_target]=King
    elseif board[x_target,y_target]=="l"
      game[x_target,y_target]=Lance
    elseif board[x_target,y_target]=="n"
      game[x_target,y_target]=Knight
    elseif board[x_target,y_target]=="p"
      game[x_target,y_target]=Pawn
    elseif board[x_target,y_target]=="r"
      game[x_target,y_target]=Rook
    elseif board[x_target,y_target]=="s"
      game[x_target,y_target]=Silver_General
    elseif board[x_target,y_target]=="B"
      game[x_target,y_target]=promoted_Bishop
    elseif board[x_target,y_target]=="G"
      game[x_target,y_target]=promoted_Gold_General
    elseif board[x_target,y_target]=="K"
      game[x_target,y_target]=promoted_King
    elseif board[x_target,y_target]=="L"
      game[x_target,y_target]=promoted_Lance
    elseif board[x_target,y_target]=="N"
      game[x_target,y_target]=promoted_Knight
    elseif board[x_target,y_target]=="P"
      game[x_target,y_target]=promoted_Pawn
    elseif board[x_target,y_target]=="R"
      game[x_target,y_target]=promoted_Rook
    elseif board[x_target,y_target]=="S"
      game[x_target,y_target]=promoted_Silver_General
    else
      game[x_target,y_target]=" "
    end
  end
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
        print(" ")#game[x_index/2,y_index/2])
      end
    end
  end
  print("\n")
end

end







  #=    continue
    elseif


      if x_index==1
        print("┌")
        continue
      end
      for index in (1:10)
        print("——")
      end
      print("\n")
      continue
    end
    for hor_index in (1:20)
      if rem(hor_index,2)==0
        print(" ")
        continue
      end
      print("┏")
    end
  print("\n")
end=#
