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

end
