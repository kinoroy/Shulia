module MonteCarlo


currentBoard = startGame("standard")
statistics = Array()
boardHistory

function __init__(board::Board)
    # Takes an instance of a Board and optionally some keyword
    # arguments.  Initializes the list of game states and the
    # statistics tables.
    global currentBoard = board
end

function updateHistory(state)
    # Takes a game state, and appends it to the history.

end

function getPlay()
    # Causes the AI to calculate the best move from the
    # current game state and return it.
end

function runSimulation()
    # Plays out a "random" game from the current position,
    # then updates the statistics tables with the result.
end

end