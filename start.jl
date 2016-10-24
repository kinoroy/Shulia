#=start.jl - Starts the game and accepts 3 command line arguments,<filename> => database
<type> => gameType, <cheating> => cheating
=#
module start
include("square.jl")
using ST
using SQLite

database = ARGS[1] #/path/to/database/file {string}
gameTypeDict = Dict("S" => "standard","M" => "minishogi")
gameType = gameTypeDict[ARGS[2]] #Either "standard" or "minishogi" {string}
cheatingDict = Dict("T" => "cheating", "F" => "legal")
cheating = cheatingDict[ARGS[3]] #Either "cheating" or "legal" {string}
board = fill!(Array(square,9,9),square())
captures = Array(square,0)
seed = time() #current unix time
db = SQLite.DB(database) #Opens the database gamefile
SQLite.query(db,"CREATE TABLE moves (move_number,move_type,sourcex,sourcey,targetx,targety,option,i_am_cheating);")
SQLite.query(db,"CREATE TABLE meta (key,value);")
SQLite.query(db,"INSERT INTO meta (key,value) VALUES (type,$(gameType));")
SQLite.query(db,"INSERT INTO meta (key,value) VALUES (legality,$(cheating));")
SQLite.query(db,"INSERT INTO meta (key,value) VALUES (seed,$(seed));")

#=----Initialize the board ----=#

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

ST.saveBoard(board)
#writedlm(captures,"captures.txt")
end
