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



function callbackq(path)
  destroy(w)
end

# do checkbutton for new game/continue


callback_add(n, callback)   ## generic way to add callback for most common event
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

w = Toplevel()
tcl("pack", "propagate", w, false) ## or pack_stop_propagate(w)

mb = Menu(w)






n1 = Button(w, "• Start a new game options")
pack(n1, expand=true, fill="both")
callback_add(n1, callbackr)
=#
