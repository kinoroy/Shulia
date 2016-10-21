module dParse
include("square.jl")
using ST
global DB
startingPositionBlack = [[9,5],[9,4],[9,6],[9,3],[9,7],[9,2],[9,8],[9,1],[9,9],
[8,8],[8,2],[7,1],[7,2],[7,3],[7,4],[7,5],[7,6],[7,7],[7,8],[7,9]]
startingPositionWhite = [[1,5],[1,4],[1,6],[1,3],[1,7],[1,2],[1,8],[1,1],[1,9],
[2,2],[2,8],[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],[3,7],[3,8],[3,9]] #startingPosition of all the pieces in Shogi
board = fill!(Array(square,9,9),square())
pieces = ["k","g1","g2","s1","s2","n1","n2","l1","l2","b","r",
"p1","p2","p3","p4","p5","p6","p7","p8"] #in order relative to startingPosition array

function dParse(pathToDatabase)

  db = SQLite.DB(pathToDatabase) #Opens the database gamefile
  #calculates all black piece positions
  for piece in eachindex(pieces)
    res = SQLite.query(db,"SELECT targetx,targety FROM moves WHERE sourcex = $(startingPositionBlack(piece)[1]) AND sourcy = $(startingPositionBlack(piece)[2]);")
    targetxNullable = res[1][1]
    targetyNullable = res[2][2]

    while(!isnull(targetyNullable)) #While we are not at the final position in the current state
      sourcex=get(targetxNullable)
      sourcey=get(targetyNullable)
      res = SQLite.query(db,"SELECT targetx,targety FROM moves WHERE sourcex = $(sourcex) AND sourcy = $(sourcey);")
      targetxNullable = res[1][1]
      targetyNullable = res[2][2]
      #End while
    end
    pieceName = pieces[piece][1]
    board[source,sourcey] = square(piecename,'b')
    #End for
  end

  #calculates all white piece positons
  for piece in eachindex(pieces)
    res = SQLite.query(db,"SELECT targetx,targety FROM moves WHERE sourcex = $(startingPositionWhite(piece)[1]) AND sourcy = $(startingPositionBlack(piece)[2]);")
    targetxNullable = res[1][1]
    targetyNullable = res[2][2]

    while(!isnull(targetyNullable)) #While we are not at the final position in the current state
      sourcex=get(targetxNullable)
      sourcey=get(targetyNullable)
      res = SQLite.query(db,"SELECT targetx,targety FROM moves WHERE sourcex = $(sourcex) AND sourcy = $(sourcey);")
      targetxNullable = res[1][1]
      targetyNullable = res[2][2]
      #End while
    end
    pieceName = pieces[piece][1]
    board[source,sourcey] = square(piecename,'w')
    #End for
  end
return board
#End function
end
#End module
end
