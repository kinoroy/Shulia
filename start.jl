#=start.jl - Starts the game and accepts 3 command line arguments,<filename> => database
<type> => gameType, <cheating> => cheating
=#
module start

using SQLite

database = ARGS[1] #/path/to/database/file {string}
gameType = ARGS[2] #Either "S" or "M" {string}
cheatingDict = Dict("T" => true, "F" => false)
cheating = cheatingDict[ARGS[3]] #Either true or false {bool}

db = SQLite.DB(database) #Opens the database gamefile

#=----Initialize the board ----=#
board = fill!(Array(square,9,9),square())
board[1,5] = square('k','w')
board[9,5] = square('k','b')
board[1,[4,6]] = square('g','w')
board[9,[4,6]] = square('g','b')
board[1,[3,7]] = square('s','w')
board[9,[3,7]] = square('s','b')
board[1,[2,8]] = square('n','w')
board[9,[2,8]] = square('n','b')
board[1,[1,9]] = square('l','w')
board[9,[1,9]] = square('l','b')
board[2,2] = square('b','w')
board[8,8] = square('b','b')
board[2,8] = square('r','w')
board[8,2] = square('r','b')
board[3,1:9] = square('p','w')
board[7,1:9] = square('p','b')

#=----Save the board to file----=#
writedlm("board.txt",board)

end
