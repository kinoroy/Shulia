
#=AIHelp.jl --
functions which will help out the AI=#
module AIHelp

function bishop(board,x::Int64,y::Int64) #Returns an array of Tuples(currentX,currentY,newX,newY) of legal coordinates to move
  #Bishop is correct
  board_max = 9
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  team = board[(x,y)][2]

  for i = 1:min(x-1,y-1)
    if !( (x-i,y-i) in keys(board))  #Empty square ahead
      push!(legalC,(x,y,x-i,y-i))
    elseif (!( get(board,(x-i,y-i),('x','x'))[2] == 'w' ) && team == 'w') || (!( get(board,(x-i,y-i),('x','x'))[2] == 'b' ) && team == 'b') #Enemy piece ahead
      push!(legalC,(x,y,x-i,y-i))
      break
    else #Friendly piece ahead
      break
    end
  end

  for i = 1:min(board_max-x,board_max-y)
    if !( (x+i,y+i) in keys(board) )
      push!(legalC,(x,y,x+i,y+i))
    elseif (!( get(board,(x+i,y+i),('x','x'))[2] == 'w' ) && team == 'w') || (!( get(board,(x+i,y+i),('x','x'))[2] == 'b' ) && team == 'b')
      push!(legalC,(x,y,x+i,y+i))
      break
    else
      break
    end
  end

  for i = 1:min(board_max-x,y-1)
    if !( (x+i,y-i) in keys(board) )
      push!(legalC,(x,y,x+i,y-i))
    elseif (!( get(board,(x+i,y-i),('x','x'))[2] == 'w' ) && team == 'w') || (!( get(board,(x+i,y-i),('x','x'))[2] == 'b' ) && team == 'b')
      push!(legalC,(x,y,x+i,y-i))
      break
    else
      break
    end
  end

  for i = 1:min(x-1,board_max-y)
    if !( (x-i,y+i) in keys(board) )
      push!(legalC,(x,y,x-i,y+i))
    elseif (!( get(board,(x-i,y+i),('x','x'))[2] == 'w' ) && team == 'w') || (!( get(board,(x-i,y+i),('x','x'))[2] == 'b' ) && team == 'b')
      push!(legalC,(x,y,x-i,y+i))
      break
    else
      break
    end
  end
  return legalC
end

function goldGeneral(board,x::Int64,y::Int64)
  board_max = 9
  team = board[(x,y)][2]
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w'
    potential=[(x,y,x,y+1),(x,y,x,y-1),(x,y,x-1,y+1),(x,y,x-1,y),(x,y,x+1,y),(x,y,x+1,y+1)]
    for i in eachindex(potential)
      if potential[i][3]<=board_max && potential[i][3]>0 && potential[i][4]<=board_max && potential[i][4]>0 #Makes sure move is not out of bounds
        if !(get(board,(potential[i][3],potential[i][4]),('x','x'))[2] == 'w') #Check that there's no friendly piece in the path
          push!(legalC,potential[i])
        end
      end
    end
  else #team == 'b'
      potential=[(x,y,x,y+1),(x,y,x,y-1),(x,y,x-1,y-1),(x,y,x-1,y),(x,y,x+1,y),(x,y,x+1,y-1)]
      for i in eachindex(potential)
        if potential[i][3]<=board_max && potential[i][3]>0 && potential[i][4]<=board_max && potential[i][4]>0 #Makes sure move is not out of bounds
          if !(get(board,(potential[i][3],potential[i][4]),('x','x'))[2] == 'b') #Check that there's no friendly piece in the path
            push!(legalC,potential[i])
          end
        end
      end
  end
  return legalC
end

function king(board,x::Int64,y::Int64)
  board_max = 9
  team = board[(x,y)][2]
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w'
    potential=[(x,y,x+1,y+1),(x,y,x,y-1),(x,y,x,y+1),(x,y,x-1,y),(x,y,x+1,y),(x,y,x-1,y-1),(x,y,x+1,y-1),(x,y,x-1,y+1)]
    for i in eachindex(potential)
      if potential[i][3]<=board_max && potential[i][3]>0 && potential[i][4]<=board_max && potential[i][4]>0 #Makes sure move is not out of bounds
        if !(get(board,(potential[i][3],potential[i][4]),('x','x'))[2] == 'w') #Check that there's no friendly piece in the path
          push!(legalC,potential[i])
        end
      end
    end
  else #Team == 'b'
    potential=[(x,y,x+1,y+1),(x,y,x,y-1),(x,y,x,y+1),(x,y,x-1,y),(x,y,x+1,y),(x,y,x-1,y-1),(x,y,x+1,y-1),(x,y,x-1,y+1)]
    for i in eachindex(potential)
      if potential[i][3]<=board_max && potential[i][3]>0 && potential[i][4]<=board_max && potential[i][4]>0 #Makes sure move is not out of bounds
        if !(get(board,(potential[i][3],potential[i][4]),('x','x')) == 'b') #Check that there's no friendly piece in the path
          push!(legalC,potential[i])
        end
      end
    end
  end

  return legalC
end

function lance(board,x::Int64,y::Int64)
  board_max = 9
  team = board[(x,y)][2]
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w'
    for i = 1:(board_max-y-1)
      if !( (x,y+i) in keys(board) ) #Empty square ahead
        push!(legalC,(x,y,x,y+i))
      elseif (!(get(board,(x,y+i),('x','x'))[2] == 'w' ) && team == 'w') || (!( get(board,(x,y+i),('x','x'))[2] == 'b' ) && team == 'b') #Enemy piece ahead
        push!(legalC,(x,y,x,y+i))
        break
      else #Friendly piece ahead
        break
      end
    end
  else #team == 'b'
    for i = 1:y-1
      if !( (x,y-i) in keys(board) ) #Empty square ahead
        push!(legalC,(x,y,x,y-i))
      elseif (!( get(board,(x,y-i),('x','x'))[2] == 'w' ) && team == 'w') || (!( get(board,(x,y-i),('x','x'))[2] == 'b' ) && team == 'b') #Enemy piece ahead
        push!(legalC,(x,y,x,y-i))
        break
      else #Friendly piece ahead
        break
      end
    end
  end
  return legalC
end
function knight(board,x::Int64,y::Int64)
  board_max = 9
  team = board[(x,y)][2]
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w'
    potential=[(x,y,x+1,y+2),(x,y,x-1,y+2)]
    for i in eachindex(potential)
      if potential[i][3]<=board_max && potential[i][3]>0 && potential[i][4]<=board_max && potential[i][4]>0 #Makes sure move is not out of bounds
        if !(get(board,(potential[i][3],potential[i][4]),('x','x'))[2] == 'w') #Check that there's no friendly piece in the path
          push!(legalC,potential[i])
        end
      end
    end
  else #team == 'b'
      potential=[(x,y,x+1,y-2),(x,y,x-1,y-2)]
      for i in eachindex(potential)
        if potential[i][3]<=board_max && potential[i][3]>0 && potential[i][4]<=board_max && potential[i][4]>0 #Makes sure move is not out of bounds
          if !(get(board,(potential[i][3],potential[i][4]),('x','x'))[2] == 'b') #Check that there's no friendly piece in the path
            push!(legalC,potential[i])
          end
        end
      end
  end
  return legalC
end

function pawn(board,x::Int64,y::Int64)
  team = board[(x,y)][2]
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w' && !( get(board,(x,y+1),('x','x'))[2] == 'w')
    push!(legalC,(x,y,x,y+1))
  elseif team == 'b' && !( get(board,(x,y-1),('x','x'))[2] == 'b')
    push!(legalC,(x,y,x,y-1))
  end
  return legalC
end

function rook(board,x::Int64,y::Int64)
  board_max = 9
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  team = board[(x,y)][2]

  for i = 1:(y-1)
    if !( (x,y-i) in keys(board) ) #Empty square ahead
      push!(legalC,(x,y,x,y-i))
    elseif (!(get(board,(x,y-1),('x','x'))[2] == 'w') && team == 'w') || (!(get(board,(x,y-1),('x','x'))[2] == 'b') && team == 'b') #Enemy piece ahead
      push!(legalC,(x,y,x,y-i))
      break
    else #Friendly piece ahead
      break
    end
  end

  for i = 1:(board_max-x)
    if !( (x+i,y) in keys(board) )
      push!(legalC,(x,y,x+i,y))
    elseif (!(get(board,(x,y+i),('x','x'))[2] == 'w') && team == 'w') || (!(get(board,(x,y+i),('x','x'))[2] == 'b') && team == 'b')
      push!(legalC,(x,y,x+i,y))
      break
    else
      break
    end
  end

  for i = 1:(x-1)
    if !( (x-i,y) in keys(board) )
      push!(legalC,(x,y,x-i,y))
    elseif (!(get(board,(x-i,y),('x','x'))[2] == 'w') && team == 'w') || (!(get(board,(x-i,y),('x','x'))[2] == 'b') && team == 'b')
      push!(legalC,(x,y,x-i,y))
      break
    else
      break
    end
  end

  for i = 1:(board_max-y)
    if !( (x,y+i) in keys(board) )
      push!(legalC,(x,y,x,y+i))
    elseif (!(get(board,(x,y+i),('x','x'))[2] == 'w') && team == 'w') || (!(get(board,(x,y+i),('x','x'))[2] == 'b') && team == 'b')
      push!(legalC,(x,y,x,y+i))
      break
    else
      break
    end
  end

  return legalC
end
function silverGeneral(board,x::Int64,y::Int64)
  board_max = 9
  team = board[(x,y)][2]
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w'
    potential=[(x,y,x,y+1),(x,y,x+1,y-1),(x,y,x-1,y+1),(x,y,x-1,y-1),(x,y,x+1,y+1)]
    for i in eachindex(potential)
      if potential[i][3]<=board_max && potential[i][3]>0 && potential[i][4]<=board_max && potential[i][4]>0 #Makes sure move is not out of bounds
        if !( get(board,(potential[i][3],potential[i][4]),('x','x'))[2] == 'w' ) #Check that there's no friendly piece in the path
          push!(legalC,potential[i])
        end
      end
    end
  else #team == 'b'
      potential=[(x,y,x,y-1),(x,y,x-1,y-1),(x,y,x-1,y+1),(x,y,x+1,y+1),(x,y,x+1,y-1)]
      for i in eachindex(potential)
        if potential[i][3]<=board_max && potential[i][3]>0 && potential[i][4]<=board_max && potential[i][4]>0 #Makes sure move is not out of bounds
          if !( get(board,(potential[i][3],potential[i][4]),('x','x'))[2] == 'b' ) #Check that there's no friendly piece in the path
            push!(legalC,potential[i])
          end
        end
      end
  end
  return legalC
end

function legalMoves(board,x,y)
  target = board[(x,y)]
  unit = target[1]
#  println("$unit at $x , $y")
  funDict = Dict('b' => bishop, 'g' => goldGeneral, 'k' => king, 'l' => lance, 'n' => knight, 'p' => pawn, 'r' => rook, 's' => silverGeneral)
  funDict[unit](board,x,y)
end

function legalMovesPlayer(board,team)
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0) #Initialize an array of tuples for coordinates
   currentTeam = team #Define currentTeam (either 'b' or 'w)
   board_max = 9
  #=for x in 1:board_max
    for y in 1:board_max
      if board[(x,y)][2] == currentTeam
        append!(legalC,legalMoves(board,x,y))
      end
    end
  end=#
  for (x,y) in keys(board)
    append!(legalC,legalMoves(board,x,y))
  end
  return legalC
end

end #End module "AI"
