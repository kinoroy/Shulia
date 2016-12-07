include("AIHelp.jl")
module BM
type Board

  state::Dict{Tuple{Int64,Int64},Tuple{String,Char}}
  currentPlayer::Char
  winner::Char # b, w, x for no winner

  Board(state, currentPlayer) = new(state, currentPlayer, 'x')

end
function startTestGame()
  board = Dict()
  board[(3,3)] = ("king",'b')
  board[(3,4)] = ("king",'w')
  return Board(board, 'b')
end

function startGame(gameType)
  board = Dict()
  if gameType == "standard"
    board[(5,1)] = ("king",'w')
    board[(5,9)] = ("king",'b')
    board[(4,1)] = ("gold general",'w')
    board[(6,1)] = ("gold general",'w')
    board[(4,9)] = ("gold general",'b')
    board[(6,9)] = ("gold general",'b')
    board[(3,1)] = ("silver general",'w')
    board[(7,1)] = ("silver general",'w')
    board[(3,9)] = ("silver general",'b')
    board[(7,9)] = ("silver general",'b')
    board[(2,1)] = ("knight",'w')
    board[(8,1)] = ("knight",'w')
    board[(2,9)] = ("knight",'b')
    board[(8,9)] = ("knight",'b')
    board[(1,1)] = ("lance",'w')
    board[(9,1)] = ("lance",'w')
    board[(1,9)] = ("lance",'b')
    board[(9,9)] = ("lance",'b')
    board[(2,2)] = ("bishop",'w')
    board[(8,8)] = ("bishop",'b')
    board[(8,2)] = ("rook",'w')
    board[(2,8)] = ("rook",'b')
    for i in 1:9
      board[(i,3)] = ("pawn",'w')
      board[(i,7)] = ("pawn",'b')
    end

  elseif gameType=="mini"

    board[(1,1)] = ("king",'w')
    board[(5,5)] = ("king",'b')
    board[(2,1)] = ("gold general",'w')
    board[(4,5)] = ("gold general",'b')
    board[(3,1)] = ("silver general",'w')
    board[(3,5)] = ("silver general",'b')
    board[(4,1)] = ("bishop",'w')
    board[(2,5)] = ("bishop",'b')
    board[(5,1)] = ("rook",'w')
    board[(1,5)] = ("rook",'b')
    board[(1,2)] = ("pawn",'w')
    board[(5,4)] = ("pawn",'b')

  elseif gameType=="chu"
    board[(1,1)] = ("lance",'w')
    board[(1,12)] = ("lance",'b')
    board[(12,1)] = ("lance",'w')
    board[(12,12)] = ("lance",'b')
    board[(2,1)] = ("ferocious leopard",'w')
    board[(2,12)] = ("ferocious leopard",'b')
    board[(11,1)] = ("ferocious leopard",'w')
    board[(11,12)] = ("ferocious leopard",'b')
    board[(3,1)] = ("copper general",'w')
    board[(3,12)] = ("copper general",'b')
    board[(10,1)] = ("copper general",'w')
    board[(10,12)] = ("copper general",'b')
    board[(4,1)] = ("silver general",'w')
    board[(4,12)] = ("silver general",'b')
    board[(9,1)] = ("silver general",'w')
    board[(9,12)] = ("silver general",'b')
    board[(5,1)] = ("gold general",'w')
    board[(5,12)] = ("gold general",'b')
    board[(8,1)] = ("gold general",'w')
    board[(8,12)] = ("gold general",'b')
    board[(6,1)] = ("king",'w')
    board[(7,12)] = ("king",'b')
    board[(7,1)] = ("drunk elephant",'w')
    board[(6,12)] = ("drunk elephant",'b')
    board[(1,2)] = ("reverse chariot",'w')
    board[(1,11)] = ("reverse chariot",'b')
    board[(12,2)] = ("reverse chariot",'w')
    board[(12,11)] = ("reverse chariot",'b')
    board[(3,2)] = ("bishop",'w')
    board[(3,11)] = ("bishop",'b')
    board[(10,2)] = ("bishop",'w')
    board[(10,11)] = ("bishop",'b')
    board[(5,2)] = ("blind tiger",'w')
    board[(5,11)] = ("blind tiger",'b')
    board[(8,2)] = ("blind tiger",'w')
    board[(8,11)] = ("blind tiger",'b')
    board[(6,2)] = ("kirin",'w')
    board[(7,11)] = ("kirin",'b')
    board[(7,2)] = ("phoenix",'w')
    board[(6,11)] = ("phoenix",'b')
    board[(1,3)] = ("side mover",'w')
    board[(1,10)] = ("side mover",'b')
    board[(12,3)] = ("side mover",'w')
    board[(12,10)] = ("side mover",'b')
    board[(2,3)] = ("vertical mover",'w')
    board[(2,10)] = ("vertical mover",'b')
    board[(11,3)] = ("vertical mover",'w')
    board[(11,10)] = ("vertical mover",'b')
    board[(3,3)] = ("rook",'w')
    board[(3,10)] = ("rook",'b')
    board[(10,3)] = ("rook",'w')
    board[(10,10)] = ("rook",'b')
    board[(4,3)] = ("dragon horse",'w')
    board[(4,10)] = ("dragon horse",'b')
    board[(9,3)] = ("dragon horse",'w')
    board[(9,10)] = ("dragon horse",'b')
    board[(5,3)] = ("dragon king",'w')
    board[(5,10)] = ("dragon king",'b')
    board[(8,3)] = ("dragon king",'w')
    board[(8,10)] = ("dragon king",'b')
    board[(6,3)] = ("lion",'w')
    board[(7,10)] = ("lion",'b')
    board[(7,3)] = ("queen",'w')
    board[(6,10)] = ("queen",'b')
    board[(4,5)] = ("go-between",'w')
    board[(4,8)] = ("go-between",'b')
    board[(9,5)] = ("go-between",'w')
    board[(9,8)] = ("go-between",'b')
    for j in 1:12
      board[(j,4)] = ("pawn",'w')
      board[(j,9)] = ("pawn",'b')
    end

  elseif gameType=="tenjiku"
    board[(1,1)] = ("lance",'w')
    board[(16,1)] = ("lance",'w')
    board[(2,1)] = ("knight",'w')
    board[(15,1)] = ("knight",'w')
    board[(3,1)] = ("ferocious leopard",'w')
    board[(14,1)] = ("ferocious leopard",'w')
    board[(4,1)] = ("iron general",'w')
    board[(13,1)] = ("iron general",'w')
    board[(5,1)] = ("copper general",'w')
    board[(12,1)] = ("copper general",'w')
    board[(6,1)] = ("silver general",'w')
    board[(11,1)] = ("silver general",'w')
    board[(7,1)] = ("gold general",'w')
    board[(10,1)] = ("gold general",'w')
    board[(9,1)] = ("drunk elephant",'w')
    board[(8,1)] = ("king",'w')
    board[(1,2)] = ("reverse chariot",'w')
    board[(16,2)] = ("reverse chariot",'w')
    board[(3,2)] = ("chariot soldier",'w')
    board[(14,2)] = ("chariot soldier",'w')
    board[(4,2)] = ("chariot soldier",'w')
    board[(13,2)] = ("chariot soldier",'w')
    board[(6,2)] = ("blind tiger",'w')
    board[(11,2)] = ("blind tiger",'w')
    board[(10,2)] = ("phoenix",'w')
    board[(7,2)] = ("kirin",'w')
    board[(9,2)] = ("queen",'w')
    board[(8,2)] = ("lion",'w')
    board[(1,3)] = ("side soldier",'w')
    board[(16,3)] = ("side soldier",'w')
    board[(2,3)] = ("vertical soldier",'w')
    board[(15,3)] = ("vertical soldier",'w')
    board[(3,3)] = ("bishop",'w')
    board[(14,3)] = ("bishop",'w')
    board[(4,3)] = ("dragon horse",'w')
    board[(13,3)] = ("dragon horse",'w')
    board[(5,3)] = ("dragon king",'w')
    board[(12,3)] = ("dragon king",'w')
    board[(6,3)] = ("water buffalo",'w')
    board[(11,3)] = ("water buffalo",'w')
    board[(7,3)] = ("fire demon",'w')
    board[(10,3)] = ("fire demon",'w')
    board[(9,3)] = ("free eagle",'w')
    board[(8,3)] = ("lion hawk",'w')
    board[(1,4)] = ("side mover",'w')
    board[(16,4)] = ("side mover",'w')
    board[(2,4)] = ("vertical mover",'w')
    board[(15,4)] = ("vertical mover",'w')
    board[(3,4)] = ("rook",'w')
    board[(14,4)] = ("rook",'w')
    board[(4,4)] = ("horned falcon",'w')
    board[(13,4)] = ("horned falcon",'w')
    board[(5,4)] = ("soaring eagle",'w')
    board[(12,4)] = ("soaring eagle",'w')
    board[(6,4)] = ("bishop general",'w')
    board[(11,4)] = ("bishop general",'w')
    board[(7,4)] = ("rook general",'w')
    board[(10,4)] = ("rook general",'w')
    board[(9,4)] = ("vice general",'w')
    board[(8,4)] = ("great general",'w')
    board[(5,6)] = ("dog",'w')
    board[(12,6)] = ("dog",'w')


    board[(1,16)] = ("lance",'b')
    board[(16,16)] = ("lance",'b')
    board[(2,16)] = ("knight",'b')
    board[(15,16)] = ("knight",'b')
    board[(3,16)] = ("ferocious leopard",'b')
    board[(14,16)] = ("ferocious leopard",'b')
    board[(4,16)] = ("iron general",'b')
    board[(13,16)] = ("iron general",'b')
    board[(5,16)] = ("copper general",'b')
    board[(12,16)] = ("copper general",'b')
    board[(6,16)] = ("silver general",'b')
    board[(11,16)] = ("silver general",'b')
    board[(7,16)] = ("gold general",'b')
    board[(10,16)] = ("gold general",'b')
    board[(8,16)] = ("drunk elephant",'b')
    board[(9,16)] = ("king",'b')
    board[(1,15)] = ("reverse chariot",'b')
    board[(16,15)] = ("reverse chariot",'b')
    board[(3,15)] = ("chariot soldier",'b')
    board[(14,15)] = ("chariot soldier",'b')
    board[(4,15)] = ("chariot soldier",'b')
    board[(13,15)] = ("chariot soldier",'b')
    board[(6,15)] = ("blind tiger",'b')
    board[(11,15)] = ("blind tiger",'b')
    board[(7,15)] = ("phoenix",'b')
    board[(10,15)] = ("kirin",'b')
    board[(8,15)] = ("queen",'b')
    board[(9,15)] = ("lion",'b')
    board[(1,14)] = ("side soldier",'b')
    board[(16,14)] = ("side soldier",'b')
    board[(2,14)] = ("vertical soldier",'b')
    board[(15,14)] = ("vertical soldier",'b')
    board[(3,14)] = ("bishop",'b')
    board[(14,14)] = ("bishop",'b')
    board[(4,14)] = ("dragon horse",'b')
    board[(13,14)] = ("dragon horse",'b')
    board[(5,14)] = ("dragon king",'b')
    board[(12,14)] = ("dragon king",'b')
    board[(6,14)] = ("water buffalo",'b')
    board[(11,14)] = ("water buffalo",'b')
    board[(7,14)] = ("fire demon",'b')
    board[(10,14)] = ("fire demon",'b')
    board[(8,14)] = ("free eagle",'b')
    board[(9,14)] = ("lion hawk",'b')
    board[(1,13)] = ("side mover",'b')
    board[(16,13)] = ("side mover",'b')
    board[(2,13)] = ("vertical mover",'b')
    board[(15,13)] = ("vertical mover",'b')
    board[(3,13)] = ("rook",'b')
    board[(14,13)] = ("rook",'b')
    board[(4,13)] = ("horned falcon",'b')
    board[(13,13)] = ("horned falcon",'b')
    board[(5,13)] = ("soaring eagle",'b')
    board[(12,13)] = ("soaring eagle",'b')
    board[(6,13)] = ("bishop general",'b')
    board[(11,13)] = ("bishop general",'b')
    board[(7,13)] = ("rook general",'b')
    board[(10,13)] = ("rook general",'b')
    board[(8,13)] = ("vice general",'b')
    board[(9,13)] = ("great general",'b')
    board[(12,11)] = ("dog",'b')
    board[(5,11)] = ("dog",'b')

    for k in 1:12
      board[(k,5)]=("pawn",'w')
      board[(k,12)]=("pawn",'b')
    end

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
        if (newBoard.state[(play[3], play[4])])[1] == "king"
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
        if (get(newBoard,(play[3], play[4]),"x"))[1] == "king"
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
  if !( ("king",'b') in values(state)) #=Hist[size(stateHist)[1]]) )=#
    return 'w'
  elseif !( ("king",'w') in values(state))
    return 'b'
  else
    return '?'
  end
end

export winner,legalPlays,next_state,nextState,currentPlayer,startTestGame,startGame
end
