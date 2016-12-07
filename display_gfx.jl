include("dParse.jl")
include("move.jl")
include("move_user_drop.jl")
include("move_user_move.jl")
include("move_user_resign.jl")
include("networking.jl")
include("start.jl")

using BM
using Tk

#change from board to tuples for all ifs



#if gametype = S

function dispgfx()



  iboard = BM.startGame("shogi")
  board = Array(Tuple{Char,Char},9,9)
  for x in 1:size(board)[1]
    for y in 1:size(board)[2]
      board[y,x]=(iboard[x,y].piece,iboard[x,y].team)
    end
  end

#FOR SHOGI



cd("./Images")
bishoppic = ("bishop.gif")
bishopimg = Image(bishoppic)
gold_generalpic = ("gold_general.gif")
gold_generalimg = Image(gold_generalpic)
kingpic = ("king.gif")
kingimg = Image(kingpic)
knightpic = ("knight.gif")
knightimg = Image(knightpic)
lancepic = ("lance.gif")
lanceimg = Image(lancepic)
pawnpic = ("pawn.gif")
pawnimg = Image(pawnpic)
promoted_bishoppic = ("promoted_bishop.gif")
promoted_bishopimg = Image(promoted_bishoppic)
promoted_knightpic = ("promoted_knight.gif")
promoted_knightimg = Image(promoted_knightpic)
promoted_lancepic = ("promoted_lance.gif")
promoted_lanceimg = Image(promoted_lancepic)
promoted_pawnpic = ("promoted_pawn.gif")
promoted_pawnimg = Image(promoted_pawnpic)
promoted_rookpic = ("promoted_rook.gif")
promoted_rookimg = Image(promoted_rookpic)
promoted_silver_generalpic = ("promoted_silver_general.gif")
promoted_silver_generalimg = Image(promoted_silver_generalpic)
rookpic = ("rook.gif")
rookimg = Image(rookpic)
silver_generalpic = ("silver_general.gif")
silver_generalimg = Image(silver_generalpic)
emptypic = ("empty.gif")
emptyimg = Image(emptypic)

bishoprpic = ("bishopr.gif")
bishoprimg = Image(bishoprpic)
gold_generalrpic = ("gold_generalr.gif")
gold_generalrimg = Image(gold_generalrpic)
kingrpic = ("kingr.gif")
kingrimg = Image(kingrpic)
knightrpic = ("knightr.gif")
knightrimg = Image(knightrpic)
lancerpic = ("lancer.gif")
lancerimg = Image(lancerpic)
pawnrpic = ("pawnr.gif")
pawnrimg = Image(pawnrpic)
promoted_bishoprpic = ("promoted_bishopr.gif")
promoted_bishoprimg = Image(promoted_bishoprpic)
promoted_knightrpic = ("promoted_knightr.gif")
promoted_knightrimg = Image(promoted_knightrpic)
promoted_lancerpic = ("promoted_lancer.gif")
promoted_lancerimg = Image(promoted_lancerpic)
promoted_pawnrpic = ("promoted_pawnr.gif")
promoted_pawnrimg = Image(promoted_pawnrpic)
promoted_rookrpic = ("promoted_rookr.gif")
promoted_rookrimg = Image(promoted_rookrpic)
promoted_silver_generalrpic = ("promoted_silver_generalr.gif")
promoted_silver_generalrimg = Image(promoted_silver_generalrpic)
rookrpic = ("rookr.gif")
rookrimg = Image(rookrpic)
silver_generalrpic = ("silver_generalr.gif")
silver_generalrimg = Image(silver_generalrpic)
emptypic = ("empty.gif")
emptyimg = Image(emptypic)




w = Toplevel("Grid")
f = Frame(w, padding = 10); pack(f, expand=true, fill="both")


shogiimgDict = Dict(('_','_')=>emptyimg,("king",'b')=>kingimg,("bishop",'b')=>bishopimg,("gold general",'b')=>gold_generalimg,
 ("knight",'b')=>knightimg,("lance",'b')=>lanceimg, ("promotedbishop",'b')=>promoted_bishopimg,("promotedlance",'b')=>promoted_lanceimg,("promotedpawn",'b')=>promoted_pawnimg,
 ("promotedrook",'b')=>promoted_rookimg,("promotedsilver general",'b')=>promoted_silver_generalimg,("rook",'b')=>rookimg,("silver general",'b')=>silver_generalimg,
 ("pawn",'b')=>pawnimg,("king",'w')=>kingrimg,("bishop",'w')=>bishoprimg,("gold general",'w')=>gold_generalrimg,
  ("knight",'w')=>knightrimg,("lance",'w')=>lancerimg, ("promotedbishop",'w')=>promoted_bishoprimg,
  ("promotedlance",'w')=>promoted_lancerimg,("promotedpawn",'w')=>promoted_pawnrimg,
  ("promotedrook",'w')=>promoted_rookrimg,("promotedsilver general",'w')=>promoted_silver_generalrimg,("rook",'w')=>rookrimg,("silver general",'w')=>silver_generalrimg,
  ("pawn",'w')=>pawnrimg)



pimg = Button(f, "",pawnimg)


#=bimg = Button(f, "",bishopimg)
gimg = Button(f, "",gold_generalimg)
nimg = Button(f, "",knightimg)
limg = Button(f, "",lanceimg)
bpimg = Button(f, "",promoted_bishopimg)
npimg = Button(f, "",promoted_knightimg)
lpimg = Button(f, "",promoted_lanceimg)
ppimg = Button(f, "",promoted_pawnimg)
rpimg = Button(f, "",promoted_rookimg)
spimg = Button(f, "",promoted_silver_generalimg)
rimg = Button(f, "",rookimg)
simg = Button(f, "",silver_generalimg)
emptypicimg = Button(f, "", emptyimg)

=#
for x in 1:9
  for y in 1:9
    grid(Button(f, "",shogiimgDict[board[x,y]]),x,y, )
  end
end

#start playing game
end
#end


#=
if gametype = M
=#

#

function rest()


  iboard = ST.loadBoard()
  board = Array(Tuple{Char,Char},5,5)
  for x in 1:size(board)[1]
    for y in 1:size(board)[2]
      board[y,x]=(iboard[x,y].piece,iboard[x,y].team)
    end
  end

#FOR MINISHOGI

#get rid of imgs in each if
#delete useless piece imgs

cd("./Images")
bishoppic = ("bishop.gif")
bishopimg = Image(bishoppic)
gold_generalpic = ("gold_general.gif")
gold_generalimg = Image(gold_generalpic)
kingpic = ("king.gif")
kingimg = Image(kingpic)
knightpic = ("knight.gif")
knightimg = Image(knightpic)
lancepic = ("lance.gif")
lanceimg = Image(lancepic)
pawnpic = ("pawn.gif")
pawnimg = Image(pawnpic)
promoted_bishoppic = ("promoted_bishop.gif")
promoted_bishopimg = Image(promoted_bishoppic)
promoted_knightpic = ("promoted_knight.gif")
promoted_knightimg = Image(promoted_knightpic)
promoted_lancepic = ("promoted_lance.gif")
promoted_lanceimg = Image(promoted_lancepic)
promoted_pawnpic = ("promoted_pawn.gif")
promoted_pawnimg = Image(promoted_pawnpic)
promoted_rookpic = ("promoted_rook.gif")
promoted_rookimg = Image(promoted_rookpic)
promoted_silver_generalpic = ("promoted_silver_general.gif")
promoted_silver_generalimg = Image(promoted_silver_generalpic)
rookpic = ("rook.gif")
rookimg = Image(rookpic)
silver_generalpic = ("silver_general.gif")
silver_generalimg = Image(silver_generalpic)
emptypic = ("empty.gif")
emptyimg = Image(emptypic)

bishoprpic = ("bishopr.gif")
bishoprimg = Image(bishoprpic)
gold_generalrpic = ("gold_generalr.gif")
gold_generalrimg = Image(gold_generalrpic)
kingrpic = ("kingr.gif")
kingrimg = Image(kingrpic)
knightrpic = ("knightr.gif")
knightrimg = Image(knightrpic)
lancerpic = ("lancer.gif")
lancerimg = Image(lancerpic)
pawnrpic = ("pawnr.gif")
pawnrimg = Image(pawnrpic)
promoted_bishoprpic = ("promoted_bishopr.gif")
promoted_bishoprimg = Image(promoted_bishoprpic)
promoted_knightrpic = ("promoted_knightr.gif")
promoted_knightrimg = Image(promoted_knightrpic)
promoted_lancerpic = ("promoted_lancer.gif")
promoted_lancerimg = Image(promoted_lancerpic)
promoted_pawnrpic = ("promoted_pawnr.gif")
promoted_pawnrimg = Image(promoted_pawnrpic)
promoted_rookrpic = ("promoted_rookr.gif")
promoted_rookrimg = Image(promoted_rookrpic)
promoted_silver_generalrpic = ("promoted_silver_generalr.gif")
promoted_silver_generalrimg = Image(promoted_silver_generalrpic)
rookrpic = ("rookr.gif")
rookrimg = Image(rookrpic)
silver_generalrpic = ("silver_generalr.gif")
silver_generalrimg = Image(silver_generalrpic)
emptypic = ("empty.gif")
emptyimg = Image(emptypic)




w = Toplevel("Grid")
f = Frame(w, padding = 10); pack(f, expand=true, fill="both")


minishogiimgDict = Dict(('_','_')=>emptyimg,("king",'b')=>kingimg,("bishop",'b')=>bishopimg,("gold general",'b')=>gold_generalimg,
 ("knight",'b')=>knightimg,("lance",'b')=>lanceimg, ("promotedbishop",'b')=>promoted_bishopimg,("promotedlance",'b')=>promoted_lanceimg,("promotedpawn",'b')=>promoted_pawnimg,
 ("promotedrook",'b')=>promoted_rookimg,("promotedsilver general",'b')=>promoted_silver_generalimg,("rook",'b')=>rookimg,("silver general",'b')=>silver_generalimg,
 ("pawn",'b')=>pawnimg,("king",'w')=>kingrimg,("bishop",'w')=>bishoprimg,("gold general",'w')=>gold_generalrimg,
  ("knight",'w')=>knightrimg,("lance",'w')=>lancerimg, ("promotedbishop",'w')=>promoted_bishoprimg,
  ("promotedlance",'w')=>promoted_lancerimg,("promotedpawn",'w')=>promoted_pawnrimg,
  ("promotedrook",'w')=>promoted_rookrimg,("promotedsilver general",'w')=>promoted_silver_generalrimg,("rook",'w')=>rookrimg,("silver general",'w')=>silver_generalrimg,
  ("pawn",'w')=>pawnrimg)







pimg = Button(f, "",pawnimg)


#=bimg = Button(f, "",bishopimg)
gimg = Button(f, "",gold_generalimg)
nimg = Button(f, "",knightimg)
limg = Button(f, "",lanceimg)
bpimg = Button(f, "",promoted_bishopimg)
npimg = Button(f, "",promoted_knightimg)
lpimg = Button(f, "",promoted_lanceimg)
ppimg = Button(f, "",promoted_pawnimg)
rpimg = Button(f, "",promoted_rookimg)
spimg = Button(f, "",promoted_silver_generalimg)
rimg = Button(f, "",rookimg)
simg = Button(f, "",silver_generalimg)
emptypicimg = Button(f, "", emptyimg)

=#
for x in 1:5
  for y in 1:5
    grid(Button(f, "",minishogiimgDict[board[x,y]]),x,y)
  end
end

#start playing game

#end

#=
if gametype = C
=#




  iboard = ST.loadBoard()
  board = Array(Tuple{Char,Char},12,12)
  for x in 1:size(board)[1]
    for y in 1:size(board)[2]
      board[y,x]=(iboard[x,y].piece,iboard[x,y].team)
    end
  end

#FOR CHU SHOGI

#get rid of imgs in each if
#add extra piece pics

cd("./Images")
bishoppic = ("bishop.gif")
bishopimg = Image(bishoppic)
gold_generalpic = ("gold_general.gif")
gold_generalimg = Image(gold_generalpic)
kingpic = ("king.gif")
kingimg = Image(kingpic)
knightpic = ("knight.gif")
knightimg = Image(knightpic)
lancepic = ("lance.gif")
lanceimg = Image(lancepic)
pawnpic = ("pawn.gif")
pawnimg = Image(pawnpic)
promoted_bishoppic = ("promoted_bishop.gif")
promoted_bishopimg = Image(promoted_bishoppic)
promoted_knightpic = ("promoted_knight.gif")
promoted_knightimg = Image(promoted_knightpic)
promoted_lancepic = ("promoted_lance.gif")
promoted_lanceimg = Image(promoted_lancepic)
promoted_pawnpic = ("promoted_pawn.gif")
promoted_pawnimg = Image(promoted_pawnpic)
promoted_rookpic = ("promoted_rook.gif")
promoted_rookimg = Image(promoted_rookpic)
promoted_silver_generalpic = ("promoted_silver_general.gif")
promoted_silver_generalimg = Image(promoted_silver_generalpic)
rookpic = ("rook.gif")
rookimg = Image(rookpic)
silver_generalpic = ("silver_general.gif")
silver_generalimg = Image(silver_generalpic)
emptypic = ("empty.gif")
emptyimg = Image(emptypic)

bishoprpic = ("bishopr.gif")
bishoprimg = Image(bishoprpic)
gold_generalrpic = ("gold_generalr.gif")
gold_generalrimg = Image(gold_generalrpic)
kingrpic = ("kingr.gif")
kingrimg = Image(kingrpic)
knightrpic = ("knightr.gif")
knightrimg = Image(knightrpic)
lancerpic = ("lancer.gif")
lancerimg = Image(lancerpic)
pawnrpic = ("pawnr.gif")
pawnrimg = Image(pawnrpic)
promoted_bishoprpic = ("promoted_bishopr.gif")
promoted_bishoprimg = Image(promoted_bishoprpic)
promoted_knightrpic = ("promoted_knightr.gif")
promoted_knightrimg = Image(promoted_knightrpic)
promoted_lancerpic = ("promoted_lancer.gif")
promoted_lancerimg = Image(promoted_lancerpic)
promoted_pawnrpic = ("promoted_pawnr.gif")
promoted_pawnrimg = Image(promoted_pawnrpic)
promoted_rookrpic = ("promoted_rookr.gif")
promoted_rookrimg = Image(promoted_rookrpic)
promoted_silver_generalrpic = ("promoted_silver_generalr.gif")
promoted_silver_generalrimg = Image(promoted_silver_generalrpic)
rookrpic = ("rookr.gif")
rookrimg = Image(rookrpic)
silver_generalrpic = ("silver_generalr.gif")
silver_generalrimg = Image(silver_generalrpic)
emptypic = ("empty.gif")
emptyimg = Image(emptypic)




w = Toplevel("Grid")
f = Frame(w, padding = 10); pack(f, expand=true, fill="both")

 # add to img Dict
imgDict = Dict(('_','_')=>emptyimg,("king",'b')=>kingimg,("bishop",'b')=>bishopimg,("gold general",'b')=>gold_generalimg,
 ("knight",'b')=>knightimg,("lance",'b')=>lanceimg, ("promotedbishop",'b')=>promoted_bishopimg,("promotedlance",'b')=>promoted_lanceimg,("promotedpawn",'b')=>promoted_pawnimg,
 ("promotedrook",'b')=>promoted_rookimg,("promotedsilver general",'b')=>promoted_silver_generalimg,("rook",'b')=>rookimg,("silver general",'b')=>silver_generalimg,
 ("pawn",'b')=>pawnimg,("king",'w')=>kingrimg,("bishop",'w')=>bishoprimg,("gold general",'w')=>gold_generalrimg,
  ("knight",'w')=>knightrimg,("lance",'w')=>lancerimg, ("promotedbishop",'w')=>promoted_bishoprimg,
  ("promotedlance",'w')=>promoted_lancerimg,("promotedpawn",'w')=>promoted_pawnrimg,
  ("promotedrook",'w')=>promoted_rookrimg,("promotedsilver general",'w')=>promoted_silver_generalrimg,("rook",'w')=>rookrimg,("silver general",'w')=>silver_generalrimg,
  ("pawn",'w')=>pawnrimg)


  "bishop" => bishop, "gold general" => goldGeneral, "king" => king, "lance" => lance, "knight" => knight,
   "pawn" => pawn, "rook" => rook, "silver general" => silverGeneral,
  "phoenix" => phoenix, "vertical mover" => verticalMover, "go-between" => goBetween,
   "queen" => queen, "lion" => lion, "dragon king" => dragonKing, "dragon horse", dragonHorse, "side mover" => sideMover,
  "kirin" => kirin, "blind tiget"=> blindTiger, "reverse chariot" => reverseChariot,
   "drunk elephant" => drunkElephant, "ferocious leopard" => ferociousLeopard, "blind tiger" => blindTiger)


   board[(2,1)] = ("ferocious leopard",'w')
   board[(2,12)] = ("ferocious leopard",'b')
   board[(3,1)] = ("copper general",'w')
   board[(3,12)] = ("copper general",'b')
   board[(7,1)] = ("drunk elephant",'w')
   board[(6,12)] = ("drunk elephant",'b')
   board[(1,2)] = ("reverse chariot",'w')
   board[(1,11)] = ("reverse chariot",'b')
   board[(5,2)] = ("blind tiger",'w')
   board[(5,11)] = ("blind tiger",'b')
   board[(6,2)] = ("kirin",'w')
   board[(7,11)] = ("kirin",'b')
   board[(7,2)] = ("phoenix",'w')
   board[(6,11)] = ("phoenix",'b')
   board[(1,3)] = ("side mover",'w')
   board[(1,10)] = ("side mover",'b')
   board[(2,3)] = ("vertical mover",'w')
   board[(2,10)] = ("vertical mover",'b')
   board[(4,3)] = ("dragon horse",'w')
   board[(4,10)] = ("dragon horse",'b')
   board[(5,3)] = ("dragon king",'w')
   board[(5,10)] = ("dragon king",'b')
   board[(6,3)] = ("lion",'w')
   board[(7,10)] = ("lion",'b')
   board[(7,3)] = ("queen",'w')
   board[(6,10)] = ("queen",'b')
   board[(4,5)] = ("go-between",'w')
   board[(4,8)] = ("go-between",'b')


pimg = Button(f, "",pawnimg)


#=bimg = Button(f, "",bishopimg)
gimg = Button(f, "",gold_generalimg)
nimg = Button(f, "",knightimg)
limg = Button(f, "",lanceimg)
bpimg = Button(f, "",promoted_bishopimg)
npimg = Button(f, "",promoted_knightimg)
lpimg = Button(f, "",promoted_lanceimg)
ppimg = Button(f, "",promoted_pawnimg)
rpimg = Button(f, "",promoted_rookimg)
spimg = Button(f, "",promoted_silver_generalimg)
rimg = Button(f, "",rookimg)
simg = Button(f, "",silver_generalimg)
emptypicimg = Button(f, "", emptyimg)

=#
for x in 1:12
  for y in 1:12
    grid(Button(f, "",imgDict[board[x,y]]),x,y)
  end
end
#start playing game

#end



#=
if gametype = T
=#




  iboard = ST.loadBoard()
  board = Array(Tuple{Char,Char},16,16)
  for x in 1:size(board)[1]
    for y in 1:size(board)[2]
      board[y,x]=(iboard[x,y].piece,iboard[x,y].team)
    end
  end

#FOR TENJIKU SHOGI

#get rid of imgs in each if
#add extra piece pics

cd("./Images")
bishoppic = ("bishop.gif")
bishopimg = Image(bishoppic)
gold_generalpic = ("gold_general.gif")
gold_generalimg = Image(gold_generalpic)
kingpic = ("king.gif")
kingimg = Image(kingpic)
knightpic = ("knight.gif")
knightimg = Image(knightpic)
lancepic = ("lance.gif")
lanceimg = Image(lancepic)
pawnpic = ("pawn.gif")
pawnimg = Image(pawnpic)
promoted_bishoppic = ("promoted_bishop.gif")
promoted_bishopimg = Image(promoted_bishoppic)
promoted_knightpic = ("promoted_knight.gif")
promoted_knightimg = Image(promoted_knightpic)
promoted_lancepic = ("promoted_lance.gif")
promoted_lanceimg = Image(promoted_lancepic)
promoted_pawnpic = ("promoted_pawn.gif")
promoted_pawnimg = Image(promoted_pawnpic)
promoted_rookpic = ("promoted_rook.gif")
promoted_rookimg = Image(promoted_rookpic)
promoted_silver_generalpic = ("promoted_silver_general.gif")
promoted_silver_generalimg = Image(promoted_silver_generalpic)
rookpic = ("rook.gif")
rookimg = Image(rookpic)
silver_generalpic = ("silver_general.gif")
silver_generalimg = Image(silver_generalpic)
emptypic = ("empty.gif")
emptyimg = Image(emptypic)

bishoprpic = ("bishopr.gif")
bishoprimg = Image(bishoprpic)
gold_generalrpic = ("gold_generalr.gif")
gold_generalrimg = Image(gold_generalrpic)
kingrpic = ("kingr.gif")
kingrimg = Image(kingrpic)
knightrpic = ("knightr.gif")
knightrimg = Image(knightrpic)
lancerpic = ("lancer.gif")
lancerimg = Image(lancerpic)
pawnrpic = ("pawnr.gif")
pawnrimg = Image(pawnrpic)
promoted_bishoprpic = ("promoted_bishopr.gif")
promoted_bishoprimg = Image(promoted_bishoprpic)
promoted_knightrpic = ("promoted_knightr.gif")
promoted_knightrimg = Image(promoted_knightrpic)
promoted_lancerpic = ("promoted_lancer.gif")
promoted_lancerimg = Image(promoted_lancerpic)
promoted_pawnrpic = ("promoted_pawnr.gif")
promoted_pawnrimg = Image(promoted_pawnrpic)
promoted_rookrpic = ("promoted_rookr.gif")
promoted_rookrimg = Image(promoted_rookrpic)
promoted_silver_generalrpic = ("promoted_silver_generalr.gif")
promoted_silver_generalrimg = Image(promoted_silver_generalrpic)
rookrpic = ("rookr.gif")
rookrimg = Image(rookrpic)
silver_generalrpic = ("silver_generalr.gif")
silver_generalrimg = Image(silver_generalrpic)
emptypic = ("empty.gif")
emptyimg = Image(emptypic)




w = Toplevel("Grid")
f = Frame(w, padding = 10); pack(f, expand=true, fill="both")

 # add to img Dict
imgDict = Dict(('_','_')=>emptyimg,('k','b')=>kingimg,('b','b')=>bishopimg,('g','b')=>gold_generalimg,
 ('n','b')=>knightimg,('l','b')=>lanceimg, ('B','b')=>promoted_bishopimg,('N','b')=>promoted_lanceimg,('P','b')=>promoted_pawnimg,
 ('R','b')=>promoted_rookimg,('S','b')=>promoted_silver_generalimg,('r','b')=>rookimg,('s','b')=>silver_generalimg,
 ('p','b')=>pawnimg,('k','w')=>kingrimg,('b','w')=>bishoprimg,('g','w')=>gold_generalrimg,
  ('n','w')=>knightrimg,('l','w')=>lancerimg, ('B','w')=>promoted_bishoprimg,('N','w')=>promoted_lancerimg,('P','w')=>promoted_pawnrimg,
  ('R','w')=>promoted_rookrimg,('S','w')=>promoted_silver_generalrimg,('r','w')=>rookrimg,('s','w')=>silver_generalrimg,
  ('p','w')=>pawnrimg)


pimg = Button(f, "",pawnimg)


#=bimg = Button(f, "",bishopimg)
gimg = Button(f, "",gold_generalimg)
nimg = Button(f, "",knightimg)
limg = Button(f, "",lanceimg)
bpimg = Button(f, "",promoted_bishopimg)
npimg = Button(f, "",promoted_knightimg)
lpimg = Button(f, "",promoted_lanceimg)
ppimg = Button(f, "",promoted_pawnimg)
rpimg = Button(f, "",promoted_rookimg)
spimg = Button(f, "",promoted_silver_generalimg)
rimg = Button(f, "",rookimg)
simg = Button(f, "",silver_generalimg)
emptypicimg = Button(f, "", emptyimg)

=#
for x in 1:16
  for y in 1:16
    grid(Button(f, "",imgDict[board[x,y]]),x,y)
  end
end
#start playing game

#end
end

export dispgfx
