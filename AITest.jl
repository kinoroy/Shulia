include("board.jl")
using BM
board = startTestGame()
global states = Array(Dict{Tuple{Int64,Int64},Tuple{Char,Char}},0)
push!(states,board.state)
seed = time()
calculationTime = 45 #Max calculation time permitted in seconds
max_moves = 100
#global wins = Dict('w'=>Dict(),'b'=>Dict())
#global plays = Dict('w'=>Dict(),'b'=>Dict())
global wins = Dict()
global plays = Dict()
global C = 1.4

function update(state)
  states.push!(state)
end

function get_play()
  global max_depth,states,wins,plays
  global max_depth = 0
  state = states[size(states)[1]]
  player = currentPlayer(states)
  legal = legalMovesPlayer(state,player)

  if size(legal)[1] == 0
    return
  elseif size(legal)[1] == 1
    return legal[1]
  end

  games = 0
  bTime = time()
  while time()-bTime < calculationTime
   println(time()-bTime)
    run_simulation()
    games += 1
  end

  moves_states = collect( (p,next_state(state,p)) for p in legal)

  println("$games, $(time()-bTime)")

  (percent_wins,moveIndex) = findmax(
  get(wins,(player,S),0)/get(plays,(player,S),1)
  for (p,S) in moves_states )
  move = moves_states[moveIndex][1]

  #=Print stats?=#
  println("Maximum depth searched: $(max_depth)")
  println("with %wins $percent_wins : move:")
  return move
end

function run_simulation() #2,3,5
  global max_depth,states,plays,wins
  visited_states = Set()
  states_copy = deepcopy(states)
  state = states_copy[size(states_copy)[1]]
  player = currentPlayer(states_copy)
  #println(player)
  expandP = true
  for i in 2:(max_moves+1)
    state = states_copy[size(states_copy)[1]]
    player = currentPlayer(states_copy)
    legalC  = legalMovesPlayer(state,player)
    moves_states = collect( (p,next_state(state,p)) for p in legalC)


    if all(collect(get(plays,(p,S),0)!=0 for (p,S) in moves_states))#Have stats
      log_total = log(
        sum(plays[(player,S)] for (p,S) in moves_states)
      )
    #  println("have all stats")
      (value,moveIndex)=findmax(
      collect(wins[(player,S)]/plays[(player,S)] + C*sqrt(log_total / plays[(player,S)]) for (p,S) in moves_states))

      (move,state) = moves_states[moveIndex]
    else #Random choice
      move = legalC[mod(Int(ceil(seed))*i,size(legalC)[1])+1] #Choose a "random" move for CURRENT PLAYER from legalC seeded from 'seed'
      state = next_state(state, move)
    end

    push!(states_copy,state)

    if expandP && !( (player,state) in keys(plays) )
      expandP = false
      plays[(player,state)] = 0
      wins[(player,state)] = 0
      if i > max_depth
        max_depth = i
      end
   end

    push!(visited_states,(player,state))
    player = currentPlayer(states)
    winner = BM.winner(states)
    if winner!='?' #The current state has a winner
      println(winner)
      break #Stop searching
    end

  end

  for x in visited_states
    if ! ( (player,state) in keys(plays))
      continue
    end
  #  println("adding")
    plays[(player,state)] += 1
    if player == winner
      wins[(player,state)] += 1
    end
  end
end
