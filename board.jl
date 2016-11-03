include("square.jl")
include("AIHelp.jl")

using ST

type Board

  state::Array{ST.square}
  currentPlayer::Char
  winner::Char # b, w, x for no winner

  Board(state, currentPlayer) = new(state, currentPlayer, 'x')

end

function startTestGame()
    board = fill!(Array(ST.square,9,9), square())
    board[5,1] = square('k','b')

    return Board(board, 'b')
end

function startGame(gameType)
  if gameType == "standard"
    board = fill!(Array(ST.square,9,9), square())
    board[5,1] = square('k','w')
    board[5,9] = square('k','b')
    board[[4,6],1] = square('g','w')
    board[[4,6],9] = square('g','b')
    board[[3,7],1] = square('s','w')
    board[[3,7],9] = square('s','b')
    board[[2,8],1] = square('n','w')
    board[[2,8],9] = square('n','b')
    board[[1,9],1] = square('l','w')
    board[[1,9],9] = square('l','b')
    board[2,2] = square('b','w')
    board[8,8] = square('b','b')
    board[8,2] = square('r','w')
    board[2,8] = square('r','b')
    board[1:9,3] = square('p','w')
    board[1:9,7] = square('p','b')

    else

    board = fill!(Array(square,5,5),square())
    board[1,1] = square('k','w')
    board[5,5] = square('k','b')
    board[1,2] = square('g','w')
    board[5,4] = square('g','b')
    board[1,3] = square('s','w')
    board[5,3] = square('s','b')
    board[1,4] = square('b','w')
    board[5,2] = square('b','b')
    board[1,5] = square('r','w')
    board[5,1] = square('r','b')
    board[2,1] = square('p','w')
    board[4,5] = square('p','b')
  end
  return Board(board, 'b')
end

function currentPlayer(board::Board)
    return board.currentPlayer
end

function nextState(board::Board, play::Tuple{Int64,Int64,Int64,Int64})
    newBoard = deepcopy(board)

    if ST.isEmpty(board.state[play[3], play[4]])
        newBoard.state[play[3], play[4]] = newBoard.state[play[1], play[2]]
        ST.clear!(newBoard.state[play[1], play[2]])
    else # target cell is not empty
        if newBoard.state[play[3], play[4]].piece == 'k'
            newBoard.winner = newBoard.currentPlayer
        end
        newBoard.state[play[3], play[4]] = newBoard.state[play[1], play[2]]
        ST.clear!(newBoard.state[play[1], play[2]])
    end

    newBoard.currentPlayer = (newBoard.currentPlayer == 'b' ? 'w' : 'b')

    return newBoard
end

function legalPlays(board::Board)
    return legalMovesPlayer(board.state, board.currentPlayer)
end

function winner(board::Board)
    return board.winner
end