using ST
#=AIHelp.jl --
functions which will help out the AI=#

function bishop(board,x::Int64,y::Int64) #Returns an array of Tuples(currentX,currentY,newX,newY) of legal coordinates to move
  #Bishop is correct
  board_max = 9
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  team = board[x,y].team

  for i = 1:min(x-1,y-1)
    if ST.isEmpty(board[x-i,y-i]) #Empty square ahead
      push!(legalC,(x,y,x-i,y-i))
    elseif (!ST.w(board[x-i,y-i]) && team == 'w') || (!ST.b(board[x-i,y-i]) && team == 'b') #Enemy piece ahead
      push!(legalC,(x,y,x-i,y-i))
      break
    else #Friendly piece ahead
      break
    end
  end

  for i = 1:min(board_max-x,board_max-y)
    if ST.isEmpty(board[x+i,y+i])
      push!(legalC,(x,y,x+i,y+i))
    elseif (!ST.w(board[x+i,y+i]) && team == 'w') || (!ST.b(board[x+i,y+i]) && team == 'b')
      push!(legalC,(x,y,x+i,y+i))
      break
    else
      break
    end
  end

  for i = 1:min(board_max-x,y-1)
    if ST.isEmpty(board[x+i,y-i])
      push!(legalC,(x,y,x+i,y-i))
    elseif (!ST.w(board[x+i,y-i]) && team == 'w') || !(ST.b(board[x+i,y-i]) && team == 'b')
      push!(legalC,(x,y,x+i,y-i))
      break
    else
      break
    end
  end

  for i = 1:min(x-1,board_max-y)
    if ST.isEmpty(board[x-i,y+i])
      push!(legalC,(x,y,x-i,y+i))
    elseif (!ST.w(board[x-i,y+i]) && team == 'w') || (!ST.b(board[x-i,y+i]) && team == 'b')
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
  team = board[x,y].team
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w'
    potential=[(x,y,x,y+1),(x,y,x,y-1),(x,y,x-1,y+1),(x,y,x-1,y),(x,y,x+1,y),(x,y,x+1,y+1)]
    for i in eachindex(potential)
      if potential[i][3]<board_max && potential[i][3]>0 && potential[i][4]<board_max && potential[i][4]>0 #Makes sure move is not out of bounds
        if !ST.w(board[potential[i][3],potential[i][4]]) #Check that there's no friendly piece in the path
          push!(legalC,potential[i])
        end
      end
    end
  else #team == 'b'
      potential=[(x,y,x,y+1),(x,y,x,y-1),(x,y,x-1,y-1),(x,y,x-1,y),(x,y,x+1,y),(x,y,x+1,y-1)]
      for i in eachindex(potential)
        if potential[i][3]<board_max && potential[i][3]>0 && potential[i][4]<board_max && potential[i][4]>0 #Makes sure move is not out of bounds
          if !ST.b(board[potential[i][3],potential[i][4]]) #Check that there's no friendly piece in the path
            push!(legalC,potential[i])
          end
        end
      end
  end
  return legalC
end

function king(board,x::Int64,y::Int64)
  board_max = 9
  team = board[x,y].team
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w'
    potential=[(x,y,x+1,y+1),(x,y,x,y-1),(x,y,x,y+1),(x,y,x-1,y),(x,y,x+1,y),(x,y,x-1,y-1),(x,y,x+1,y-1),(x,y,x-1,y+1)]
    for i in eachindex(potential)
      if potential[i][3]<board_max && potential[i][3]>0 && potential[i][4]<board_max && potential[i][4]>0 #Makes sure move is not out of bounds
        if !ST.w(board[potential[i][3],potential[i][4]]) #Check that there's no friendly piece in the path
          push!(legalC,potential[i])
        end
      end
    end
  else #Team == 'b'
    potential=[(x,y,x+1,y+1),(x,y,x,y-1),(x,y,x,y+1),(x,y,x-1,y),(x,y,x+1,y),(x,y,x-1,y-1),(x,y,x+1,y-1),(x,y,x-1,y+1)]
    for i in eachindex(potential)
      if potential[i][3]<board_max && potential[i][3]>0 && potential[i][4]<board_max && potential[i][4]>0 #Makes sure move is not out of bounds
        if !ST.b(board[potential[i][3],potential[i][4]]) #Check that there's no friendly piece in the path
          push!(legalC,potential[i])
        end
      end
    end
  end

  return legalC
end

function lance(board,x::Int64,y::Int64)
  board_max = 9
  team = board[x,y].team
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w'
    for i = 1:(9-y-1)
      if ST.isEmpty(board[x,y+i]) #Empty square ahead
        push!(legalC,(x,y,x,y+i))
      elseif (!ST.w(board[x,y+i]) && team == 'w') || (!ST.b(board[x,y+i]) && team == 'b') #Enemy piece ahead
        push!(legalC,(x,y,x,y+i))
        break
      else #Friendly piece ahead
        break
      end
    end
  else #team == 'b'
    for i = 1:y-1
      if ST.isEmpty(board[x,y-i]) #Empty square ahead
        push!(legalC,(x,y,x,y-i))
      elseif (!ST.w(board[x,y-i]) && team == 'w') || (!ST.b(board[x,y-i]) && team == 'b') #Enemy piece ahead
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
  team = board[x,y].team
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w'
    potential=[(x,y,x+1,y+2),(x,y,x-1,y+2)]
    for i in eachindex(potential)
      if potential[i][3]<board_max && potential[i][3]>0 && potential[i][4]<board_max && potential[i][4]>0 #Makes sure move is not out of bounds
        if !ST.w(board[potential[i][3],potential[i][4]]) #Check that there's no friendly piece in the path
          push!(legalC,potential[i])
        end
      end
    end
  else #team == 'b'
      potential=[(x,y,x+1,y-2),(x,y,x-1,y-2)]
      for i in eachindex(potential)
        if potential[i][3]<board_max && potential[i][3]>0 && potential[i][4]<board_max && potential[i][4]>0 #Makes sure move is not out of bounds
          if !ST.b(board[potential[i][3],potential[i][4]]) #Check that there's no friendly piece in the path
            push!(legalC,potential[i])
          end
        end
      end
  end
  return legalC
end

function pawn(board,x::Int64,y::Int64)
  team = board[x,y].team
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w' && !ST.w(board[x,y+1])
    push!(legalC,(x,y,x,y+1))
  elseif team == 'b' && !ST.b(board[x,y-1])
    push!(legalC,(x,y,x,y-1))
  end
  return legalC
end

function rook(board,x::Int64,y::Int64)
  board_max = 9
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  team = board[x,y].team

  for i = 1:(y-1)
    if ST.isEmpty(board[x,y-i]) #Empty square ahead
      push!(legalC,(x,y,x,y-i))
    elseif (!ST.w(board[x,y-i]) && team == 'w') || (!ST.b(board[x,y-i]) && team == 'b') #Enemy piece ahead
      push!(legalC,(x,y,x,y-i))
      break
    else #Friendly piece ahead
      break
    end
  end

  for i = 1:(board_max-x)
    if ST.isEmpty(board[x+i,y])
      push!(legalC,(x,y,x+i,y))
    elseif (!ST.w(board[x+i,y]) && team == 'w') || (!ST.b(board[x+i,y]) && team == 'b')
      push!(legalC,(x,y,x+i,y))
      break
    else
      break
    end
  end

  for i = 1:(x-1)
    if ST.isEmpty(board[x-i,y])
      push!(legalC,(x,y,x-i,y))
    elseif (!ST.w(board[x-i,y]) && team == 'w') || !(ST.b(board[x-i,y]) && team == 'b')
      push!(legalC,(x,y,x-i,y))
      break
    else
      break
    end
  end

  for i = 1:(board_max-y)
    if ST.isEmpty(board[x,y+i])
      push!(legalC,(x,y,x,y+i))
    elseif (!ST.w(board[x,y+i]) && team == 'w') || (!ST.b(board[x,y+i]) && team == 'b')
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
  team = board[x,y].team
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0)
  if team == 'w'
    potential=[(x,y,x,y+1),(x,y,x+1,y-1),(x,y,x-1,y+1),(x,y,x-1,y-1),(x,y,x+1,y+1)]
    for i in eachindex(potential)
      if potential[i][3]<board_max && potential[i][3]>0 && potential[i][4]<board_max && potential[i][4]>0 #Makes sure move is not out of bounds
        if !ST.w(board[potential[i][3],potential[i][4]]) #Check that there's no friendly piece in the path
          push!(legalC,potential[i])
        end
      end
    end
  else #team == 'b'
      potential=[(x,y,x,y-1),(x,y,x-1,y-1),(x,y,x-1,y+1),(x,y,x+1,y+1),(x,y,x+1,y-1)]
      for i in eachindex(potential)
        if potential[i][3]<board_max && potential[i][3]>0 && potential[i][4]<board_max && potential[i][4]>0 #Makes sure move is not out of bounds
          if !ST.b(board[potential[i][3],potential[i][4]]) #Check that there's no friendly piece in the path
            push!(legalC,potential[i])
          end
        end
      end
  end
  return legalC
end

function legalMoves(board,x,y)
  target = board[x,y]
  unit = target.piece
#  println("$unit at $x , $y")
  funDict = Dict('b' => bishop, 'g' => goldGeneral, 'k' => king, 'l' => lance, 'n' => knight, 'p' => pawn, 'r' => rook, 's' => silverGeneral)
  funDict[unit](board,x,y)
end

function legalMovesPlayer(board,team)
  legalC = Array(Tuple{Int64,Int64,Int64,Int64},0) #Initialize an array of tuples for coordinates
   currentTeam = team #Define currentTeam (either 'b' or 'w)
  for x in 1:9
    for y in 1:9
      if board[x,y].team == currentTeam
        append!(legalC,legalMoves(board,x,y))
      end
    end
  end
  return legalC
end

function expand(state)
  state.visits = 1
  state.value = 0
end
function update_value(state,winner)
  if winner == state.turn
    state.reward += 1
  else
    state.reward -= 1
  end
end
function random_playout(state)
  turnDict=Dict(0 =>'b',1=> 'w')
  if state.terminal
    return state.turn
  else
  legalC = legalMovesPlayer(state.board,turnDict[state.turn])
  println(legalC)
  println(ceil(mod(seed,size(legalC)[1])))
  randomAction = Int(ceil(mod(seed,size(legalC)[1])))
  new_state = Tree.Node(state.board,legalC[randomAction])
  Tree.addChild!(state,new_state)
    return random_playout(new_state)
  end
end

type board
  state::Array{ST.square}
  board(state) = new(state)

end

==(t1 :: board, t2 :: board) = true
function hashBoard(target::Array{ST.square})

end

#=timeMoveBegins = time()
maxTime 60 = #in seconds (300 is 5 min)
root = Node((0,0,0,0)) #root "action" is current state (no action)
currentNode = root =#
#while time()-timeMoveBegins < maxTime #Do MCTS while we have time
function MCTS(state)
  state.visits += 1 #Update the number of visits for this node
  currentNode = state
  #=----Determines childToExplore----=#
  if size(currentNode.children)[1] == 0 #Leaf node, |Simulation Step|
    next_state = currentNode
    winner = random_playout(next_state)
  else #Node has children,
    unvisited = Array(Int64,0)
    for i in eachindex(currentNode.children)
      if currentNode.children[i].visits == 0
        push!(unvisited,i)
      end
    end
    if size(unvisited)[1] == 0 #All Nodes expanded, pick the best one via UCB1 |Selection Step|
      UCBS = Array(Float64,0)
      children = currentNode.children
      for i in eachindex(currentNode.children)
        push!(UCBS,children[i].reward + sqrt((2*ln(currentNode.visits))/(children[i].visits)))
      end
      next_state = currentNode.children[find(x->x==maximum(UCBS),UCBS)[1]] #This is the child we want to explore: With max UCB1
      winner =  MCTS_sample(next_state)
    else #Some nodes not expanded, pick random one and expand it
      randomAction = ceil(mod(seed,size(unvisited)[1])) #seed is the time of game creation
      next_state = currentNode.children[Int(randomAction)] #This is the "random" child to expand
      winner = random_playout(next_state)
    end
    update_value(state,winner)
  end


end #End function
#end #end while

function run_simulation() #2,3,5
  states_copy = states[:]
  state = states_copy[-1]
  max_moves= 100 #How is this determined?

  for i in 1:(max_moves)
    legalC  = legalMovesPlayer(board,currentPlayer)

    play = legalC[seed] #Choose a "random" move from legalC seeded from 'seed'
    state = self.board.next_state(state, play)
    states_copy.append!(state)

    winner = win(states_copy)
    if winner!='?' #The current state has a winner
      break #Stop searching
    end
  end

end
