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
