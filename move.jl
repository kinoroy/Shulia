#=move.jl - Updates the game file with a move, accepts 1 command line argument,<filename> => database
=#

  include("dParse.jl")
module move

  using dParse
  using ST
  using SQLite

global db
global database
  #= ---- Opens the Database for reading ---- =#
  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile
  #=----Parses the database and determines where pieces are on the board----=#
  dParse(database)
  board = ST.loadBoard()
  #= ---- Determines whos turn it is (white or black) ---- =#

  res = SQLite.query(db,"SELECT MAX(move_number) FROM moves;") #Finds the last played move (maximum move_number)
  lastMoveIDNullable = res[1,1] #SQL query with max move_number (POSSIBLY "NULL" if no moves have been made)

  if (!isnull(lastMoveIDNullable)) #Checks that lastMoveID was not NULL
    lastMoveID = get(res[1,1]) #Parses the last move move_number as an Int

  else #lastMoveID is NULL
    lastMoveID = 0 #move_number "0" is unsused. This implies no moves have been made

  end

  #=---- Determines a move to make (AI integration below)----=#
  move_number = lastMoveID+1 #The current move is move#: move_number


  #Todo: write AI: must define variables: move_type, sourcex, sourcey, targetx, targety, option, i_am_cheating
function MC_BoardEval(state):
   wins = 0
   losses = 0
   for i=1:NUM_SAMPLES
     next_state = state
     while non_terminal(next_state):
       next_state = random_legal_move(next_state)
       if next_state.winner == state.turn: wins++
       else: losses++ #needs slight modification if draws possible
       return (wins - losses) / (wins + losses)
     end
   end
 end


  # ---- Saves the determined move in the database ---- =#
  SQLite.query(db,"INSERT INTO moves (move_number, move_type, sourcex, sourcey, targetx, targety, option, i_am_cheating)
  VALUES ($(move_number),$(move_type),$sourcex, $sourcey,$targetx, $targety, $option, $(i_am_cheating));")


#=Helper Functions to AI:=#
function non_terminal(target)
  return !dParse(target)
end#End function

end#End Module
