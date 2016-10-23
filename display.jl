#=display.jl - will replay the game
from start to finish, displaying the current game state.
Accepts 1 command line argument,<filename> => database
=#

module display
using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile

board=Array{AbstractString}(9,9)
for i in (1:9)
  for y in (1:9)
    board[i,y]=" "
  end
end

board[1,9]="a"
board[1,8]="b"
board[1,7]="c"
board[1,6]="d"
board[1,5]="e"
board[1,4]="f"
board[1,3]="g"
board[1,2]="h"
board[1,1]="i"
board[2,8]="j"
board[2,2]="k"
board[3,9]="l"
board[3,8]="m"
board[3,7]="n"
board[3,6]="o"
board[3,5]="p"
board[3,4]="q"
board[3,3]="r"
board[3,2]="s"
board[3,1]="t"

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
        if board[div(x_index,2),(10-div(y_index,2))]=="e"
          print_with_color(:green, board[div(x_index,2),(10-div(y_index,2))])
          continue
        end
        print(board[div(x_index,2),(10-div(y_index,2))])
      end
    end
  end
  print("\n")
end

end
