#=display.jl - will replay the game
from start to finish, displaying the current game state.
Accepts 1 command line argument,<filename> => database
=#

module display
include("square.jl")
using ST


iboard = ST.loadBoard()
board = Array(Char,9,9)
for i in eachindex(iboard)
  board[i]=iboard[i].piece
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
        if board[div(x_index,2),(10-div(y_index,2))]=='k'
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
