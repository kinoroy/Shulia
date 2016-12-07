#=start.jl - Starts the game and accepts 7 function call aruments:
=#
include("board.jl")
module start

using BM

using SQLite

function startShogi(database,gameTypein,cheatingin,timed,time_add,sente_time,gote_time)

#  database = ARGS[1] #/path/to/database/file {string}
  gameTypeDict = Dict("S" => "standard","M" => "minishogi")
  gameType = gameTypeDict[gameTypein] #Either "standard" or "minishogi" {string}
  cheatingDict = Dict("T" => "cheating", "F" => "legal")
  cheating = cheatingDict[cheatingin] #Either "cheating" or "legal" {string}=#
  #timed is "yes" or "no"
  #captures = Array(square(),0)
  seed = time() #current unix time
  db = SQLite.DB(database) #Opens the database gamefile
  SQLite.query(db,"CREATE TABLE moves (move_number,move_type,sourcex,sourcey,targetx,targety,option,i_am_cheating,targetx2,targety2,targetx3,targety3);")
  SQLite.query(db,"CREATE TABLE meta (key,value);")
  SQLite.query(db,"""INSERT INTO meta (key,value) VALUES ("type","$(gameType)");""")
  SQLite.query(db,"""INSERT INTO meta (key,value) VALUES ("legality","$(cheating)");""")
  SQLite.query(db,"""INSERT INTO meta (key,value) VALUES ("seed","$(seed)");""")
  SQLite.query(db,"""INSERT INTO meta (key,value) VALUES ("timed","$(timed)");""")
  SQLite.query(db,"""INSERT INTO meta (key,value) VALUES ("time_add","$(time_add)");""")
  SQLite.query(db,"""INSERT INTO meta (key,value) VALUES ("sente_time","$(sente_time)");""")
  SQLite.query(db,"""INSERT INTO meta (key,value) VALUES ("gote_time","$(gote_time)");""")

end
export startShogi
end
