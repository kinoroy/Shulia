include("AIHelp.jl")
module BM
type Board

  state::Dict{Tuple{Int64,Int64},Tuple{Char,Char}}
  currentPlayer::Char
  winner::Char # b, w, x for no winner

  Board(state, currentPlayer) = new(state, currentPlayer, 'x')

end

function startTestGame()
    board = Dict()
    board[(1,4)] = ('r','b')
    board[(4,4)] = ('k','b')
    board[(1,1)] = ('k','w')
    return Board(board, 'b')
end

function startGame(gameType)
  board = Dict()
  if gameType == "standard"
    board[(5,1)] = ('k','w')
    board[(5,9)] = ('k','b')
    board[(4,1)] = ('g','w')
    board[(6,1)] = ('g','w')
    board[(4,9)] = ('g','b')
    board[(6,9)] = ('g','b')
    board[(3,1)] = ('s','w')
    board[(7,1)] = ('s','w')
    board[(3,9)] = ('s','b')
    board[(7,9)] = ('s','b')
    board[(2,1)] = ('n','w')
    board[(8,1)] = ('n','w')
    board[(2,9)] = ('n','b')
    board[(8,9)] = ('n','b')
    board[(1,1)] = ('l','w')
    board[(9,1)] = ('l','w')
    board[(1,9)] = ('l','b')
    board[(9,9)] = ('l','b')
    board[(2,2)] = ('b','w')
    board[(8,8)] = ('b','b')
    board[(8,2)] = ('r','w')
    board[(2,8)] = ('r','b')
    for i in 1:9
      board[(i,3)] = ('p','w')
      board[(i,7)] = ('p','b')
    end

  elseif gameType=="mini"

    board[(1,1)] = ('k','w')
    board[(5,5)] = ('k','b')
    board[(1,2)] = ('g','w')
    board[(5,4)] = ('g','b')
    board[(1,3)] = ('s','w')
    board[(5,3)] = ('s','b')
    board[(1,4)] = ('b','w')
    board[(5,2)] = ('b','b')
    board[(1,5)] = ('r','w')
    board[(5,1)] = ('r','b')
    board[(2,1)] = ('p','w')
    board[(4,5)] = ('p','b')

  elseif gameType=="chu"
    board[(1,1)] = ('l','w')
    board[(1,12)] = ('l','b')
    board[(12,1)] = ('l','w')
    board[(12,12)] = ('l','b')
    board[(2,1)] = ('f','w')
    board[(2,12)] = ('f','b')
    board[(11,1)] = ('f','w')
    board[(11,12)] = ('f','b')
    board[(3,1)] = ('c','w')
    board[(3,12)] = ('c','b')
    board[(10,1)] = ('c','w')
    board[(10,12)] = ('c','b')
    board[(4,1)] = ('s','w')
    board[(4,12)] = ('s','b')
    board[(9,1)] = ('s','w')
    board[(9,12)] = ('s','b')
    board[(5,1)] = ('g','w')
    board[(5,12)] = ('g','b')
    board[(8,1)] = ('g','w')
    board[(8,12)] = ('g','b')
    board[(6,1)] = ('k','w')
    board[(7,12)] = ('k','b')
    board[(7,1)] = ('e','w')
    board[(6,12)] = ('e','b')
    board[(1,2)] = ('a','w')
    board[(1,11)] = ('a','b')
    board[(12,2)] = ('a','w')
    board[(12,11)] = ('a','b')
    board[(3,2)] = ('b','w')
    board[(3,11)] = ('b','b')
    board[(10,2)] = ('b','w')
    board[(10,11)] = ('b','b')
    board[(5,2)] = ('t','w')
    board[(5,11)] = ('t','b')
    board[(8,2)] = ('t','w')
    board[(8,11)] = ('t','b')
    board[(6,2)] = ('n','w')
    board[(7,11)] = ('n','b')
    board[(7,2)] = ('x','w')
    board[(6,11)] = ('x','b')
    board[(1,3)] = ('m','w')
    board[(1,10)] = ('m','b')
    board[(12,3)] = ('m','w')
    board[(12,10)] = ('m','b')
    board[(2,3)] = ('v','w')
    board[(2,10)] = ('v','b')
    board[(11,3)] = ('v','w')
    board[(11,10)] = ('v','b')
    board[(3,3)] = ('r','w')
    board[(3,10)] = ('r','b')
    board[(10,3)] = ('r','w')
    board[(10,10)] = ('r','b')
    board[(4,3)] = ('h','w')
    board[(4,10)] = ('h','b')
    board[(9,3)] = ('h','w')
    board[(9,10)] = ('h','b')
    board[(5,3)] = ('d','w')
    board[(5,10)] = ('d','b')
    board[(8,3)] = ('d','w')
    board[(8,10)] = ('d','b')
    board[(6,3)] = ('i','w')
    board[(7,10)] = ('i','b')
    board[(7,3)] = ('q','w')
    board[(6,10)] = ('q','b')
    board[(4,5)] = ('o','w')
    board[(4,8)] = ('o','b')
    board[(9,5)] = ('o','w')
    board[(9,8)] = ('o','b')
    for j in 1:12
      board[(j,4)] = ('p','w')
      board[(j,9)] = ('p','b')
    end

  elseif gameType=="tenjiku"

  end
  return Board(board, 'b')
end

function currentPlayer(stateHist)
    return iseven(size(stateHist)[1]) ? 'w' : 'b' #size=1 is the starting state, no moves have been made
end

function nextState(board::Board, play::Tuple{Int64,Int64,Int64,Int64})
    newBoard = deepcopy(board)

    if ! ((play[3], play[4]) in newBoard.state.keys) #Target is empty
        newBoard.state[(play[3], play[4])] = newBoard.state[(play[1], play[2])]
        delete!(newBoard.state[(play[1], play[2])])
    else # target cell is not empty
        if (newBoard.state[(play[3], play[4])])[1] == 'k'
            newBoard.winner = newBoard.currentPlayer
        end
        newBoard.state[(play[3], play[4])] = newBoard.state[(play[1], play[2])]
        delete!(newBoard,(play[1], play[2]))
    end

    newBoard.currentPlayer = (newBoard.currentPlayer == 'b' ? 'w' : 'b')

    return newBoard
end

function next_state(target, play::Tuple{Int64,Int64,Int64,Int64})
    newBoard = deepcopy(target)

    if ! ((play[3], play[4]) in newBoard.keys) #Target is empty
        newBoard[(play[3], play[4])] = newBoard[(play[1], play[2])]
        delete!(newBoard,(play[1], play[2]))
    else # target cell is not empty
        if (get(newBoard,(play[3], play[4]),'x'))[1] == 'k'
            #newBoard.winner = newBoard.currentPlayer
        end
        newBoard[(play[3], play[4])] = newBoard[(play[1], play[2])]
        delete!(newBoard,(play[1], play[2]))
    end

    #newBoard.currentPlayer = (newBoard.currentPlayer == 'b' ? 'w' : 'b')

    return newBoard
end

function legalPlays(board::Board)
    return legalMovesPlayer(board.state, board.currentPlayer)
end

function winner(state)
  if !( ('k','b') in values(state)) #=Hist[size(stateHist)[1]]) )=#
    return 'w'
  elseif !( ('k','w') in values(state))
    return 'b'
  else
    return '?'
  end
end

export winner,legalPlays,next_state,nextState,currentPlayer,startTestGame,startGame
end
