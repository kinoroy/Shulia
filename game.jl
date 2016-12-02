#=Shogi!
Authors: Kino, Amirrezera, Regan, Sam, Rulai
=#
#TO DO: Consoliate includes to top level (dparse,AIhelp , etc...)
include("start.jl")
include("move.jl")
include("move_user_move.jl")
include("move_user_drop.jl")
include("move_user_resign.jl")
include("networking.jl")
include("validate.jl")
include("validateTenjiku.jl")
include("win.jl")
include("display_gfx.jl")
using start
using move
using move_user_resign
using move_user_move
using move_user_drop
using networking
using win
#............ more modules
include("menus.jl") #Start the GUI
