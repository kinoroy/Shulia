w = Toplevel()
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















n = Button(w, "• Start a new game")
o = Button(w, "• Continue an old game")
r = Button(w, "• Replay a finished game")
q = Button(w, "• Quit")




pack(n, expand=true, fill="both")
pack(o, expand=true, fill="both")
pack(r, expand=true, fill="both")
pack(q, expand=true, fill="both")





function callback(path)
  vals = map(get_value, (cb, rb))
  println(vals)
end


function callbackr(path)
  aa = Messagebox(w, message="Are you sure you want to quit")
  msg = aa[:textvariable]
end


function callbacknOPT(path)
  y = Toplevel()
  f = Frame(y)
  pack(f, expand=true, fill="both")
  cbc = Checkbutton(f, "I hate Julia")
  pack(cbc)

  function callback(path)        ## callbacks have at least one argument
    value = get_value(cbc)
    msg = value ? "WOW you're mean" : "but I hate her"
    Messagebox(y, title="Thanks for the feedback", message=msg)
  end

  bind(cbc, "command", callback)   ## bind to command option

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
  callback_add(nVSAI, callbacknOPT)

  nVSH = Button(x, "• Start a game against a human on the same computer")
  pack(nVSH, expand=true, fill="both")
  callback_add(nVSH, callback)

  nJOIN = Button(x, "• Join a game against a remote program")
  pack(nJOIN, expand=true, fill="both")
  callback_add(nJOIN, callback)


  nHAI = Button(x, "• Host a game, using your AI as the player")
  pack(nHAI, expand=true, fill="both")
  callback_add(nHAI, callback)

  nHH = Button(x, "• Host a game, with a human as the player")
  pack(nHH, expand=true, fill="both")
  callback_add(nHH, callback)

  nE = Button(x, "• Start a new game over email")
  pack(nE, expand=true, fill="both")
  callback_add(nE, callback)


end



# do checkbutton for new game/continue


callback_add(n, callbackn)   ## generic way to add callback for most common event
callback_add(o, callback)
callback_add(r, callback)
callback_add(q, callbackq)

#=

bind(okk, "<Return>", callbackr)

#okk =
println(okk)
#bind(okk, "command", callbackr)


if okk == "Ok"
  println("yes")
end

=#

#=

x = Toplevel()
tcl("pack", "propagate", x, false) ## or pack_stop_propagate(w)

mb = Menu(x)






n1 = Button(x, "• Start a new game options")
pack(n1, expand=true, fill="both")
callback_add(n1, callbackr)
=#
