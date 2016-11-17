#include("dParse.jl")

using Tk



  iboard = ST.loadBoard()
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
for x in 1:9
  for y in 1:9
    grid(Button(f, "",imgDict[board[x,y]]),x,y)
  end
end
