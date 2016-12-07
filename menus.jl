#=
include("display_gfx.jl")
include("move.jl")
include("move_user_drop.jl")
include("move_user_move.jl")
include("move_user_resign.jl")
include("networking.jl")
include("start.jl")
include("board.jl")


=#






w = Toplevel("SHOGI", 400, 300)
tcl("pack", "propagate", w, false) ## or pack_stop_propagate(w)

mb = Menu(w)            ## makes menu, adds to top-level window
fmenu = menu_add(mb, "File")
omenu = menu_add(mb, "Options")

menu_add(fmenu, "Open file...", (path) -> println("Open file dialog, ..."))
menu_add(fmenu, Separator(w))   ## second argument is Tk_Separator instance
menu_add(fmenu, "Close window", (path) -> destroy(w))

cb = Checkbutton(w, "Something visible")
set_value(cb, false)     ## initialize
menu_add(omenu, cb)     ## second argument is Tk_Checkbutton instance

menu_add(omenu, Separator(w))   ## put in a separator

rb = Radio(w, ["option 1", "option 2"])
set_value(rb, "option 1")   ## initialize
menu_add(omenu, rb)     ## second argument is Tk_Radio instance


global JRMvalue
JRMvalue = false
global VARvalue
VARvalue = "no shogi"
global DIFFvalue
DIFFvalue = "not normal"
global CHEATvalue
CHEATvalue = false
global FIRSTvalue
FIRSTvalue = false
global TIMEvalue
TIMEvalue = false
global LIMITvalue
LIMITvalue = "infinity"
global TheTimeLimit
TheTimeLimit = 0
global VSAI
VSAI = false
global VSH
VSH = false
global HAI
VSAI = false
global HSH
VSH = false




n = Button(w, "• Start a new game")
o = Button(w, "• Continue an old game")
r = Button(w, "• Replay a finished game")
q = Button(w, "• Quit")




pack(n, expand=true, fill="both")
pack(o, expand=true, fill="both")
pack(r, expand=true, fill="both")
pack(q, expand=true, fill="both")


function callbackLIMIT(path)

  global JRMvalue
  global VARvalue
  global DIFFvalue
  global CHEATvalue
  global FIRSTvalue
  global TIMEvalue
  global LIMITvalue
  global TheTimeLimit
  global VSAI
  global VSH
  global HAI
  global HSH
  z = Toplevel()
  f = Frame(z); pack(f, expand=true, fill="both")


#sepextra3 = Label(f, "                         ")
#pack(sepextra2, expand=true, fill="both")

e = Entry(f)
b = Button(f, "Ok")

formlayout(e, "Time Limit (seconds):")
formlayout(b, nothing)
focus(e)            ## put keyboard focus on widget

#=
map(u -> pack(u, anchor="w"), (e, b))

cbcTIME =Checkbutton(f, "Use time limit")
map(u -> pack(u, anchor="w"), (sepextra3, cbcTIME))


pack(sepextra3, expand=true, fill="both")
pack(cbcTIME, expand=true, fill="both")
=#


#make different functions for each path
function callbackLIMITTIME(path)
  global JRMvalue
  global VARvalue
  global DIFFvalue
  global CHEATvalue
  global FIRSTvalue
  global TIMEvalue
  global TheTimeLimit
  global VSAI
  global VSH
  global HAI
  global HSH

  global LIMITvalue = get_value(e)
  println("$LIMITvalue")
  #msg = "You have a nice name $val"
  #Messagebox(w,  msg)
  global TheTimeLimit
  if  TIMEvalue == true
    if parse(Int64,LIMITvalue) >= 1
      TheTimeLimit = parse(Int64,LIMITvalue)
    #  println("the time limit is :$TheTimeLimit")
    end
  end
#=
  JRM = false
  if  JRMvalue == true
      JRM = JRMvalue
      println("japanese roulette mode? :$JRM")
  end




  shvar = " "
  if  VARvalue != "no shogi"
      shvar = VARvalue
      println("shogi variant :$shvar")
  else
    shvar = "yes shogi"
    println("shogi variant :$shvar")
  end



  dfvar = " "
  if  DIFFvalue != "not normal"
      dfvar = DIFFvalue
      println("difficulty :$dfvar")
  else
    dfvar = "normal"
    println("difficulty :$dfvar")
  end



  CHEAT = false
  if  CHEATvalue == true
      CHEAT = CHEATvalue
      println("cheating? :$CHEAT")
  end




  FIRST = false
  if  FIRSTvalue == true
      FIRST = FIRSTvalue
      println("going first? :$FIRST")
  end
=#
  #return LIMITvalue


#while true
#  dispgfx()

end

bind(b, "command", callbackLIMITTIME)
bind(b, "<Return>", callbackLIMITTIME)
bind(e, "<Return>", callbackLIMITTIME)  ## bind to a certain key press event

#=
if  TIMEvalue == true
  if parse(Int64,LIMITvalue) >= 1
    TheTimeLimit = parse(Int64,LIMITvalue)
    println("the time limit is :$TheTimeLimit")
  end
end


JRM = false
if  JRMvalue == true
    JRM = JRMvalue
    println("japanese roulette mode? :$JRM")
end




shvar = " "
if  VARvalue != "no shogi"
    shvar = VARvalue
    println("shogi variant :$shvar")
else
  shvar = "yes shogi"
  println("shogi variant :$shvar")
end



dfvar = " "
if  DIFFvalue != "not normal"
    dfvar = DIFFvalue
    println("difficulty :$dfvar")
else
  dfvar = "normal"
  println("difficulty :$dfvar")
end



CHEAT = false
if  CHEATvalue == true
    CHEAT = CHEATvalue
    println("cheating? :$CHEAT")
end




FIRST = false
if  FIRSTvalue == true
    FIRST = FIRSTvalue
    println("going first? :$FIRST")
end

=#


end


function callback(path)
  vals = map(get_value, (cb, rb))
  println(vals)
end


function callbackr(path)
  aa = Messagebox(w, message="Are you sure you want to quit")
  msg = aa[:textvariable]
end


function callbacknVSAIOPT(path)
  y = Toplevel("Options")
  f = Frame(y)
  pack(f, expand=true, fill="both")




  global JRMvalue
#  JRMvalue = false
  global VARvalue
#  VARvalue = "shogi"
  global DIFFvalue
#  DIFFvalue = "normal"
  global CHEATvalue
#  CHEATvalue = false
  global FIRSTvalue
#  FIRSTvalue = false
  global TIMEvalue
#  TIMEvalue = false
  global LIMITvalue
#  LIMITvalue = "infinity"
global VSAI
VSAI = true
global VSH
global HAI
global HSH

  cbcJRM =Checkbutton(f, "Japanese roulette mode")
  #pack(cbcJRM)
  pack(cbcJRM, expand=true, fill="both")


  sepextra = Label(f, "                         ")



  cbcCHEAT =Checkbutton(f, "Permit AI to cheat")
  map(u -> pack(u, anchor="w"), (sepextra, cbcCHEAT))

  #=
  pack(sepextra, expand=true, fill="both")
  pack(cbcCHEAT, expand=true, fill="both")
=#

  sepextra1 = Label(f, "                         ")



  cbcFIRST =Checkbutton(f, "Go First")
  map(u -> pack(u, anchor="w"), (sepextra1, cbcFIRST))
  #=
  pack(sepextra1, expand=true, fill="both")
  pack(cbcFIRST, expand=true, fill="both")

  =#
  sepextra2 = Label(f, "                         ")



  cbcTIME =Checkbutton(f, "Use time limit")
  map(u -> pack(u, anchor="w"), (sepextra2, cbcTIME))
  #=
  pack(sepextra2, expand=true, fill="both")
  pack(cbcTIME, expand=true, fill="both")

  =#




  sep1 = Label(f, "                         ")


  varmes  = Label(f, "shogi variant:")
  vartype = Radio(f, ["shogi", "minishogi", "chu shogi", "tenjiku shogi"])
  #b  = Button(f, "ok") #at the end
  map(u -> pack(u, anchor="w"), (sep1, varmes, vartype))     ## pack in left to right
#=
  pack(sep1, expand=true, fill="both")
  pack(varmes, expand=true, fill="both")
  pack(vartype, expand=true, fill="both")
=#

  sep2 = Label(f, "                         ")


  diffmes  = Label(f, "difficulty:")
  difftype = Radio(f, ["normal", "hard", "suicidal", "protracted death", "random AI"])
  #b  = Button(f, "ok") #at the end
  map(u -> pack(u, anchor="w"), (sep2, diffmes, difftype))     ## pack in left to right
#=
  pack(sep2, expand=true, fill="both")
  pack(diffmes, expand=true, fill="both")
  pack(difftype, expand=true, fill="both")
=#

bOK = Button(y, "Ok")
pack(bOK, expand=true, fill="both")










  function callbackJRM(path)        ## callbacks have at least one argument
    global JRMvalue = get_value(cbcJRM)
    println("$JRMvalue")
    return JRMvalue
  end


  function callbackCHEAT(path)        ## callbacks have at least one argument
    global CHEATvalue = get_value(cbcCHEAT)
    println("$CHEATvalue")
    return CHEATvalue
  end

  function callbackFIRST(path)        ## callbacks have at least one argument
    global FIRSTvalue = get_value(cbcFIRST)
    println("$FIRSTvalue")
    return FIRSTvalue
  end

  function callbackTIME(path)        ## callbacks have at least one argument
    global TIMEvalue = get_value(cbcTIME)
    println("$TIMEvalue")
    return TIMEvalue
  end


  function callbackvar(path)
  #=  msg = (get_value(rb) == "apples") ? "Good choice!  An apple a day keeps the doctor away!" :
                                        "Good choice!  Oranges are full of Vitamin C!"
=#
    global VARvalue = get_value(vartype)
    println("$VARvalue")
  #  Messagebox(w, msg)
    return VARvalue
  end


  function callbackdiff(path)
  #=  msg = (get_value(rb) == "apples") ? "Good choice!  An apple a day keeps the doctor away!" :
                                        "Good choice!  Oranges are full of Vitamin C!"
  =#
    global DIFFvalue = get_value(difftype)
    println("$DIFFvalue")
  #  Messagebox(w, msg)
    return DIFFvalue
  end






  bind(cbcJRM, "command", callbackJRM)   ## bind to command option
#  println("$JRMvalue")

  bind(cbcCHEAT, "command", callbackCHEAT)   ## bind to command option

  bind(cbcFIRST, "command", callbackFIRST)   ## bind to command option

  bind(cbcTIME, "command", callbackTIME)   ## bind to command option



  bind(vartype, "command", callbackvar)


  bind(difftype, "command", callbackdiff)

#  bind(bOK, "command", callback)
#  bind(bOK, "<Return>", callback)


  #if TIMEvalue == true
    bind(bOK, "command", callbackLIMIT)
    bind(bOK, "<Return>", callbackLIMIT)
    callback_add(bOK, callbackLIMIT)
  #end




end

function callbacknVSHOPT(path)
  y = Toplevel("Options")
  f = Frame(y)
  pack(f, expand=true, fill="both")




  global JRMvalue
#  JRMvalue = false
  global VARvalue
#  VARvalue = "shogi"
  #global DIFFvalue
  #DIFFvalue = "normal"
  #global CHEATvalue
  #CHEATvalue = false
  #global FIRSTvalue
  #FIRSTvalue = false
  global TIMEvalue
#  TIMEvalue = false
  global LIMITvalue
#  LIMITvalue = "infinity"
global VSAI
global VSH
VSH = true
global HAI
global HSH

  cbcJRM =Checkbutton(f, "Japanese roulette mode")
  #pack(cbcJRM)
  pack(cbcJRM, expand=true, fill="both")

#=
  sepextra = Label(f, "                         ")



  cbcCHEAT =Checkbutton(f, "Permit AI to cheat")
  map(u -> pack(u, anchor="w"), (sepextra, cbcCHEAT))
=#
  #=
  pack(sepextra, expand=true, fill="both")
  pack(cbcCHEAT, expand=true, fill="both")
=#


#=
  sepextra1 = Label(f, "                         ")



  cbcFIRST =Checkbutton(f, "Go First")
  map(u -> pack(u, anchor="w"), (sepextra1, cbcFIRST))

  =#
  #=
  pack(sepextra1, expand=true, fill="both")
  pack(cbcFIRST, expand=true, fill="both")

  =#
  sepextra2 = Label(f, "                         ")



  cbcTIME =Checkbutton(f, "Use time limit")
  map(u -> pack(u, anchor="w"), (sepextra2, cbcTIME))
  #=
  pack(sepextra2, expand=true, fill="both")
  pack(cbcTIME, expand=true, fill="both")

  =#




  sep1 = Label(f, "                         ")


  varmes  = Label(f, "shogi variant:")
  vartype = Radio(f, ["shogi", "minishogi", "chu shogi", "tenjiku shogi"])
  #b  = Button(f, "ok") #at the end
  map(u -> pack(u, anchor="w"), (sep1, varmes, vartype))     ## pack in left to right
#=
  pack(sep1, expand=true, fill="both")
  pack(varmes, expand=true, fill="both")
  pack(vartype, expand=true, fill="both")
=#
#=
  sep2 = Label(f, "                         ")


  diffmes  = Label(f, "difficulty:")
  difftype = Radio(f, ["normal", "hard", "suicidal", "protracted death", "random AI"])
  #b  = Button(f, "ok") #at the end
  map(u -> pack(u, anchor="w"), (sep2, diffmes, difftype))     ## pack in left to right


=#
#=
  pack(sep2, expand=true, fill="both")
  pack(diffmes, expand=true, fill="both")
  pack(difftype, expand=true, fill="both")
=#

bOK = Button(y, "Ok")
pack(bOK, expand=true, fill="both")










  function callbackJRM(path)        ## callbacks have at least one argument
    global JRMvalue = get_value(cbcJRM)
    println("$JRMvalue")
    return JRMvalue
  end

#=
  function callbackCHEAT(path)        ## callbacks have at least one argument
    global CHEATvalue = get_value(cbcCHEAT)
    println("$CHEATvalue")
    return CHEATvalue
  end

  function callbackFIRST(path)        ## callbacks have at least one argument
    global FIRSTvalue = get_value(cbcFIRST)
    println("$FIRSTvalue")
    return FIRSTvalue
  end
=#


  function callbackTIME(path)        ## callbacks have at least one argument
    global TIMEvalue = get_value(cbcTIME)
    println("$TIMEvalue")
    return TIMEvalue
  end


  function callbackvar(path)
  #=  msg = (get_value(rb) == "apples") ? "Good choice!  An apple a day keeps the doctor away!" :
                                        "Good choice!  Oranges are full of Vitamin C!"
=#
    global VARvalue = get_value(vartype)
    println("$VARvalue")
  #  Messagebox(w, msg)
    return VARvalue
  end


#  function callbackdiff(path)
  #=  msg = (get_value(rb) == "apples") ? "Good choice!  An apple a day keeps the doctor away!" :
                                        "Good choice!  Oranges are full of Vitamin C!"
=#
  #  global DIFFvalue = get_value(difftype)
  #  println("$DIFFvalue")
  #  Messagebox(w, msg)
  #  return DIFFvalue
  #end






  bind(cbcJRM, "command", callbackJRM)   ## bind to command option
#  println("$JRMvalue")

#  bind(cbcCHEAT, "command", callbackCHEAT)   ## bind to command option

#  bind(cbcFIRST, "command", callbackFIRST)   ## bind to command option

  bind(cbcTIME, "command", callbackTIME)   ## bind to command option



  bind(vartype, "command", callbackvar)


#  bind(difftype, "command", callbackdiff)

#  bind(bOK, "command", callback)
#  bind(bOK, "<Return>", callback)


  #if TIMEvalue == true
    bind(bOK, "command", callbackLIMIT)
    bind(bOK, "<Return>", callbackLIMIT)
    callback_add(bOK, callbackLIMIT)
  #end




end
function callbacknHAIOPT(path)
  y = Toplevel("Options")
  f = Frame(y)
  pack(f, expand=true, fill="both")




  global JRMvalue
#  JRMvalue = false
  global VARvalue
#  VARvalue = "shogi"
  #global DIFFvalue
  #DIFFvalue = "normal"
  #global CHEATvalue
  #CHEATvalue = false
  #global FIRSTvalue
  #FIRSTvalue = false
  global TIMEvalue
#  TIMEvalue = false
  global LIMITvalue
#  LIMITvalue = "infinity"
global VSAI
global VSH
global HAI
VSAI = true
global HSH


  cbcJRM =Checkbutton(f, "Japanese roulette mode")
  #pack(cbcJRM)
  pack(cbcJRM, expand=true, fill="both")

#=
  sepextra = Label(f, "                         ")



  cbcCHEAT =Checkbutton(f, "Permit AI to cheat")
  map(u -> pack(u, anchor="w"), (sepextra, cbcCHEAT))
=#
  #=
  pack(sepextra, expand=true, fill="both")
  pack(cbcCHEAT, expand=true, fill="both")
=#


#=
  sepextra1 = Label(f, "                         ")



  cbcFIRST =Checkbutton(f, "Go First")
  map(u -> pack(u, anchor="w"), (sepextra1, cbcFIRST))

  =#
  #=
  pack(sepextra1, expand=true, fill="both")
  pack(cbcFIRST, expand=true, fill="both")

  =#
  sepextra2 = Label(f, "                         ")



  cbcTIME =Checkbutton(f, "Use time limit")
  map(u -> pack(u, anchor="w"), (sepextra2, cbcTIME))
  #=
  pack(sepextra2, expand=true, fill="both")
  pack(cbcTIME, expand=true, fill="both")

  =#




  sep1 = Label(f, "                         ")


  varmes  = Label(f, "shogi variant:")
  vartype = Radio(f, ["shogi", "minishogi", "chu shogi", "tenjiku shogi"])
  #b  = Button(f, "ok") #at the end
  map(u -> pack(u, anchor="w"), (sep1, varmes, vartype))     ## pack in left to right
#=
  pack(sep1, expand=true, fill="both")
  pack(varmes, expand=true, fill="both")
  pack(vartype, expand=true, fill="both")
=#
#=
  sep2 = Label(f, "                         ")


  diffmes  = Label(f, "difficulty:")
  difftype = Radio(f, ["normal", "hard", "suicidal", "protracted death", "random AI"])
  #b  = Button(f, "ok") #at the end
  map(u -> pack(u, anchor="w"), (sep2, diffmes, difftype))     ## pack in left to right


=#
#=
  pack(sep2, expand=true, fill="both")
  pack(diffmes, expand=true, fill="both")
  pack(difftype, expand=true, fill="both")
=#

bOK = Button(y, "Ok")
pack(bOK, expand=true, fill="both")










  function callbackJRM(path)        ## callbacks have at least one argument
    global JRMvalue = get_value(cbcJRM)
    println("$JRMvalue")
    return JRMvalue
  end

#=
  function callbackCHEAT(path)        ## callbacks have at least one argument
    global CHEATvalue = get_value(cbcCHEAT)
    println("$CHEATvalue")
    return CHEATvalue
  end

  function callbackFIRST(path)        ## callbacks have at least one argument
    global FIRSTvalue = get_value(cbcFIRST)
    println("$FIRSTvalue")
    return FIRSTvalue
  end
=#


  function callbackTIME(path)        ## callbacks have at least one argument
    global TIMEvalue = get_value(cbcTIME)
    println("$TIMEvalue")
    return TIMEvalue
  end


  function callbackvar(path)
  #=  msg = (get_value(rb) == "apples") ? "Good choice!  An apple a day keeps the doctor away!" :
                                        "Good choice!  Oranges are full of Vitamin C!"
=#
    global VARvalue = get_value(vartype)
    println("$VARvalue")
  #  Messagebox(w, msg)
    return VARvalue
  end


#  function callbackdiff(path)
  #=  msg = (get_value(rb) == "apples") ? "Good choice!  An apple a day keeps the doctor away!" :
                                        "Good choice!  Oranges are full of Vitamin C!"
=#
  #  global DIFFvalue = get_value(difftype)
  #  println("$DIFFvalue")
  #  Messagebox(w, msg)
  #  return DIFFvalue
  #end






  bind(cbcJRM, "command", callbackJRM)   ## bind to command option
#  println("$JRMvalue")

#  bind(cbcCHEAT, "command", callbackCHEAT)   ## bind to command option

#  bind(cbcFIRST, "command", callbackFIRST)   ## bind to command option

  bind(cbcTIME, "command", callbackTIME)   ## bind to command option



  bind(vartype, "command", callbackvar)


#  bind(difftype, "command", callbackdiff)

#  bind(bOK, "command", callback)
#  bind(bOK, "<Return>", callback)


  #if TIMEvalue == true
    bind(bOK, "command", callbackLIMIT)
    bind(bOK, "<Return>", callbackLIMIT)
    callback_add(bOK, callbackLIMIT)
  #end




end





function callbacknHHOPT(path)
  y = Toplevel("Options")
  f = Frame(y)
  pack(f, expand=true, fill="both")




  global JRMvalue
#  JRMvalue = false
  global VARvalue
#  VARvalue = "shogi"
  #global DIFFvalue
  #DIFFvalue = "normal"
  #global CHEATvalue
  #CHEATvalue = false
  #global FIRSTvalue
  #FIRSTvalue = false
  global TIMEvalue
#  TIMEvalue = false
  global LIMITvalue
#  LIMITvalue = "infinity"
global VSAI
global VSH
global HAI
global HSH
VSH = true


  cbcJRM =Checkbutton(f, "Japanese roulette mode")
  #pack(cbcJRM)
  pack(cbcJRM, expand=true, fill="both")

#=
  sepextra = Label(f, "                         ")



  cbcCHEAT =Checkbutton(f, "Permit AI to cheat")
  map(u -> pack(u, anchor="w"), (sepextra, cbcCHEAT))
=#
  #=
  pack(sepextra, expand=true, fill="both")
  pack(cbcCHEAT, expand=true, fill="both")
=#


#=
  sepextra1 = Label(f, "                         ")



  cbcFIRST =Checkbutton(f, "Go First")
  map(u -> pack(u, anchor="w"), (sepextra1, cbcFIRST))

  =#
  #=
  pack(sepextra1, expand=true, fill="both")
  pack(cbcFIRST, expand=true, fill="both")

  =#
  sepextra2 = Label(f, "                         ")



  cbcTIME =Checkbutton(f, "Use time limit")
  map(u -> pack(u, anchor="w"), (sepextra2, cbcTIME))
  #=
  pack(sepextra2, expand=true, fill="both")
  pack(cbcTIME, expand=true, fill="both")

  =#




  sep1 = Label(f, "                         ")


  varmes  = Label(f, "shogi variant:")
  vartype = Radio(f, ["shogi", "minishogi", "chu shogi", "tenjiku shogi"])
  #b  = Button(f, "ok") #at the end
  map(u -> pack(u, anchor="w"), (sep1, varmes, vartype))     ## pack in left to right
#=
  pack(sep1, expand=true, fill="both")
  pack(varmes, expand=true, fill="both")
  pack(vartype, expand=true, fill="both")
=#
#=
  sep2 = Label(f, "                         ")


  diffmes  = Label(f, "difficulty:")
  difftype = Radio(f, ["normal", "hard", "suicidal", "protracted death", "random AI"])
  #b  = Button(f, "ok") #at the end
  map(u -> pack(u, anchor="w"), (sep2, diffmes, difftype))     ## pack in left to right


=#
#=
  pack(sep2, expand=true, fill="both")
  pack(diffmes, expand=true, fill="both")
  pack(difftype, expand=true, fill="both")
=#

bOK = Button(y, "Ok")
pack(bOK, expand=true, fill="both")










  function callbackJRM(path)        ## callbacks have at least one argument
    global JRMvalue = get_value(cbcJRM)
    println("$JRMvalue")
    return JRMvalue
  end

#=
  function callbackCHEAT(path)        ## callbacks have at least one argument
    global CHEATvalue = get_value(cbcCHEAT)
    println("$CHEATvalue")
    return CHEATvalue
  end

  function callbackFIRST(path)        ## callbacks have at least one argument
    global FIRSTvalue = get_value(cbcFIRST)
    println("$FIRSTvalue")
    return FIRSTvalue
  end
=#


  function callbackTIME(path)        ## callbacks have at least one argument
    global TIMEvalue = get_value(cbcTIME)
    println("$TIMEvalue")
    return TIMEvalue
  end


  function callbackvar(path)
  #=  msg = (get_value(rb) == "apples") ? "Good choice!  An apple a day keeps the doctor away!" :
                                        "Good choice!  Oranges are full of Vitamin C!"
=#
    global VARvalue = get_value(vartype)
    println("$VARvalue")
  #  Messagebox(w, msg)
    return VARvalue
  end


#  function callbackdiff(path)
  #=  msg = (get_value(rb) == "apples") ? "Good choice!  An apple a day keeps the doctor away!" :
                                        "Good choice!  Oranges are full of Vitamin C!"
=#
  #  global DIFFvalue = get_value(difftype)
  #  println("$DIFFvalue")
  #  Messagebox(w, msg)
  #  return DIFFvalue
  #end






  bind(cbcJRM, "command", callbackJRM)   ## bind to command option
#  println("$JRMvalue")

#  bind(cbcCHEAT, "command", callbackCHEAT)   ## bind to command option

#  bind(cbcFIRST, "command", callbackFIRST)   ## bind to command option

  bind(cbcTIME, "command", callbackTIME)   ## bind to command option



  bind(vartype, "command", callbackvar)


#  bind(difftype, "command", callbackdiff)

#  bind(bOK, "command", callback)
#  bind(bOK, "<Return>", callback)


  #if TIMEvalue == true
    bind(bOK, "command", callbackLIMIT)
    bind(bOK, "<Return>", callbackLIMIT)
    callback_add(bOK, callbackLIMIT)
  #end




end

function callbacknEOPT(path)
  y = Toplevel("Options")
  f = Frame(y)
  pack(f, expand=true, fill="both")




  global JRMvalue
#  JRMvalue = false
  global VARvalue
#  VARvalue = "shogi"
  #global DIFFvalue
  #DIFFvalue = "normal"
  #global CHEATvalue
  #CHEATvalue = false
  #global FIRSTvalue
  #FIRSTvalue = false
  global TIMEvalue
#  TIMEvalue = false
  global LIMITvalue
#  LIMITvalue = "infinity"
global VSAI
global VSH
global HAI
global HSH


  cbcJRM =Checkbutton(f, "Japanese roulette mode")
  #pack(cbcJRM)
  pack(cbcJRM, expand=true, fill="both")

#=
  sepextra = Label(f, "                         ")



  cbcCHEAT =Checkbutton(f, "Permit AI to cheat")
  map(u -> pack(u, anchor="w"), (sepextra, cbcCHEAT))
=#
  #=
  pack(sepextra, expand=true, fill="both")
  pack(cbcCHEAT, expand=true, fill="both")
=#


#=
  sepextra1 = Label(f, "                         ")



  cbcFIRST =Checkbutton(f, "Go First")
  map(u -> pack(u, anchor="w"), (sepextra1, cbcFIRST))

  =#
  #=
  pack(sepextra1, expand=true, fill="both")
  pack(cbcFIRST, expand=true, fill="both")

  =#
  sepextra2 = Label(f, "                         ")



  cbcTIME =Checkbutton(f, "Use time limit")
  map(u -> pack(u, anchor="w"), (sepextra2, cbcTIME))
  #=
  pack(sepextra2, expand=true, fill="both")
  pack(cbcTIME, expand=true, fill="both")

  =#




  sep1 = Label(f, "                         ")


  varmes  = Label(f, "shogi variant:")
  vartype = Radio(f, ["shogi", "minishogi", "chu shogi", "tenjiku shogi"])
  #b  = Button(f, "ok") #at the end
  map(u -> pack(u, anchor="w"), (sep1, varmes, vartype))     ## pack in left to right
#=
  pack(sep1, expand=true, fill="both")
  pack(varmes, expand=true, fill="both")
  pack(vartype, expand=true, fill="both")
=#
#=
  sep2 = Label(f, "                         ")


  diffmes  = Label(f, "difficulty:")
  difftype = Radio(f, ["normal", "hard", "suicidal", "protracted death", "random AI"])
  #b  = Button(f, "ok") #at the end
  map(u -> pack(u, anchor="w"), (sep2, diffmes, difftype))     ## pack in left to right


=#
#=
  pack(sep2, expand=true, fill="both")
  pack(diffmes, expand=true, fill="both")
  pack(difftype, expand=true, fill="both")
=#

bOK = Button(y, "Ok")
pack(bOK, expand=true, fill="both")










  function callbackJRM(path)        ## callbacks have at least one argument
    global JRMvalue = get_value(cbcJRM)
    println("$JRMvalue")
    return JRMvalue
  end

#=
  function callbackCHEAT(path)        ## callbacks have at least one argument
    global CHEATvalue = get_value(cbcCHEAT)
    println("$CHEATvalue")
    return CHEATvalue
  end

  function callbackFIRST(path)        ## callbacks have at least one argument
    global FIRSTvalue = get_value(cbcFIRST)
    println("$FIRSTvalue")
    return FIRSTvalue
  end
=#


  function callbackTIME(path)        ## callbacks have at least one argument
    global TIMEvalue = get_value(cbcTIME)
    println("$TIMEvalue")
    return TIMEvalue
  end


  function callbackvar(path)
  #=  msg = (get_value(rb) == "apples") ? "Good choice!  An apple a day keeps the doctor away!" :
                                        "Good choice!  Oranges are full of Vitamin C!"
=#
    global VARvalue = get_value(vartype)
    println("$VARvalue")
  #  Messagebox(w, msg)
    return VARvalue
  end


#  function callbackdiff(path)
  #=  msg = (get_value(rb) == "apples") ? "Good choice!  An apple a day keeps the doctor away!" :
                                        "Good choice!  Oranges are full of Vitamin C!"
=#
  #  global DIFFvalue = get_value(difftype)
  #  println("$DIFFvalue")
  #  Messagebox(w, msg)
  #  return DIFFvalue
  #end






  bind(cbcJRM, "command", callbackJRM)   ## bind to command option
#  println("$JRMvalue")

#  bind(cbcCHEAT, "command", callbackCHEAT)   ## bind to command option

#  bind(cbcFIRST, "command", callbackFIRST)   ## bind to command option

  bind(cbcTIME, "command", callbackTIME)   ## bind to command option



  bind(vartype, "command", callbackvar)


#  bind(difftype, "command", callbackdiff)

#  bind(bOK, "command", callback)
#  bind(bOK, "<Return>", callback)


  #if TIMEvalue == true
    bind(bOK, "command", callbackLIMIT)
    bind(bOK, "<Return>", callbackLIMIT)
    callback_add(bOK, callbackLIMIT)
  #end




end


function callbackq(path)
  destroy(w)
end




function callbackn(path)
  x = Toplevel("New Game", 400, 300)
  tcl("pack", "propagate", x, false) ## or pack_stop_propagate(w)

  mb = Menu(x)

  nVSAI = Button(x, "• Start a game against the AI")
  pack(nVSAI, expand=true, fill="both")
  callback_add(nVSAI, callbacknVSAIOPT)

  nVSH = Button(x, "• Start a game against a human on the same computer")
  pack(nVSH, expand=true, fill="both")
  callback_add(nVSH, callbacknVSHOPT)

  nJOIN = Button(x, "• Join a game against a remote program")
  pack(nJOIN, expand=true, fill="both")
  #join a game(networking)
  callback_add(nJOIN, callback)
  #callback_add(nJOIN, callbacknJOIN)


  nHAI = Button(x, "• Host a game, using your AI as the player")
  pack(nHAI, expand=true, fill="both")
  callback_add(nHAI, callbacknHAIOPT)

  nHH = Button(x, "• Host a game, with a human as the player")
  pack(nHH, expand=true, fill="both")
  callback_add(nHH, callbacknHHOPT)

  nE = Button(x, "• Start a new game over email")
  pack(nE, expand=true, fill="both")
  callback_add(nE, callbacknEOPT)
#=
As play by email, I meant: Produce a game file that the other side would read.
Your program does not do the sending. Just create a game file database
and tell the user where it is. The user does the emailing.
=#

end


function callbacko(path)
  x = Toplevel("New Game", 400, 300)
  tcl("pack", "propagate", x, false) ## or pack_stop_propagate(w)

  mb = Menu(x)

  oLOCAL = Button(x, "• Continue a local game")
  pack(oLOCAL, expand=true, fill="both")
  #open local game
  callback_add(oLOCAL, callback)



  oEMAIL = Button(x, "• • Take a turn in an email game")
  pack(oEMAIL, expand=true, fill="both")
  #open email game
  callback_add(oEMAIL, callback)


end


function callbackr(path)
  a=1
  #open saved file
end





callback_add(n, callbackn)   ## generic way to add callback for most common event
callback_add(o, callbacko)
callback_add(r, callbackr)
callback_add(q, callbackq)

#=

TheTimeLimit = 0
if  TIMEvalue == true
  if parse(Int64,LIMITvalue) >= 1
    TheTimeLimit = parse(Int64,LIMITvalue)
    println("the time limit is :$TheTimeLimit")
  end
end




JRM = false
if  JRMvalue == true
    JRM = JRMvalue
    println("japanese roulette mode? :$JRM")
end




shvar = " "
if  VARvalue != "no shogi"
    shvar = VARvalue
    println("shogi variant :$shvar")
else
  shvar = "yes shogi"
  println("shogi variant :$shvar")
end



dfvar = " "
if  DIFFvalue != "not normal"
    dfvar = DIFFvalue
    println("difficulty :$dfvar")
else
  dfvar = "normal"
  println("difficulty :$dfvar")
end



CHEAT = false
if  CHEATvalue == true
    CHEAT = CHEATvalue
    println("cheating? :$CHEAT")
end




FIRST = false
if  FIRSTvalue == true
    FIRST = FIRSTvalue
    println("going first? :$FIRST")
end

=#



#send extracted data to gamefile
