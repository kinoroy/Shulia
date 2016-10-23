#=display.jl - will replay the game
from start to finish, displaying the current game state.
Accepts 1 command line argument,<filename> => database
=#

module display
using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile

board=Array{AbstractString}(9,9)#needs to assign the board before display
for i in (1:9)
  for y in (1:9)
    board[i,y]=" "
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
        if board[div(x_index,2),(10-div(y_index,2))]=="k"
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
