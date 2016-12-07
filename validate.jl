#=validate.jl - replay the game from start to the current move, at every step making
sure that the rules were kept. Print 0 is the game was played cleanly so far and the move ID
of the violating move if it wasn’t. Accepts 1 command line argument,<filename> => database
=#

#=
Only captured targets can be dropped
Dropped cannot capture a piece
It is not promoted instantly
Pawn, knight, lance cannot be dropped on the furthest rank
Pawn cannot be dropped on the same column (y) as another unpromoted pawn
Pawn cannot checkmate only checks
=#
module validateMod

include("board.jl")
include("dParse.jl")
gameType = "standard" #TO DO: don't hard code this
  using BM
  using SQLite
  board = (BM.startGame(gameType)).state
  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile


  #returns True if move is Valid, False otherwise
  function moveValidate(unit, moveType, gameType, team, sourcex, sourcey, targetx, targety, targetx2, targety2)

    #edge 0, sourcex or source y are null but it is not drop
    if ( (sourcex == -1 || sourcey == -1) && moveType != "drop")
      return false
    end

    #edge 1, source and target are the same
    if (sourcex == targetx) && (sourcey == targety)
      return false
    end

    #edge 2, source or target are out of bounds
    if (gameType == "standard") #normalShogi
      if  (~(sourcex >= 1 && sourcex <= 9) || ~(sourcey >= 1 && sourcey <= 9) || ~(targetx >= 1 && targetx <= 9) || ~(targety >= 1 && targety <= 9))
        return false
      end
    elseif (gameType == "minishogi") #miniShogi
      if  (~(sourcex >= 1 && sourcex <= 5) || ~(sourcey >= 1 && sourcey <= 5) || ~(targetx >= 1 && targetx <= 5) || ~(targety >= 1 && targety <= 5))
        return false
      end
    elseif (gameType == "chu") #chuShogi
      if  (~(sourcex >= 1 && sourcex <= 12) || ~(sourcey >= 1 && sourcey <= 12) || ~(targetx >= 1 && targetx <= 12) || ~(targety >= 1 && targety <= 12))
        return false
      end
    end

    #drop case
    if (moveType == "drop")

      #Chu Shogi has no drops
      if (moveType == "chu")
        return false
      end

      #drop case 1: Dropped cannot capture
      if (targetx,targety) in keys(board)
        return false
      end

      #drop case 2: Pawn, Knight, Lance cannot be dropped on the furthest rank
      if (unit == "pawn" || unit == "knight" || unit == "lance")
        if (team == 'b') #team black
          if (targetx == 1)
            return false
          end
        elseif (team =='w') #team white
          if (targetx == 9)
            return false
          end
        end
      end

      #drop case3: It is not promoted
      if (unit == "promotedbishop" || unit == "promotedlance" || unit == "promotedknight" || unit == "promotedpawn" || unit == "promotedrook" || unit == "promotedsilver general")
        return false
      end

      #drop case4: Pawns cannot be dropped on the same column as another unpromoted pawn
      if (unit == "pawn")
        for x in 1:9
          if (board[(x,targety)][1] == "pawn") #there is a pawn
            return false
          end
        end
      end

      #drop case5: Pawns cannot checkmate #missing

      #drop case6: Capture targets can be dropped #missing

    end

    #case 1 bishop
    if unit == "bishop"
      return bishopValidate(team,sourcex,sourcey,targetx,targety)

    #case 1.2 promoted bishop or dragon Horse
    elseif unit == "promotedbishop"
        return pBishopValidate(team,sourcex,sourcey,targetx,targety)
      end

    #case 2 gold general
    elseif unit == "goldgeneral"
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #case 3 king
    elseif unit == "king"
      return kingValidate(team,sourcex,sourcey,targetx,targety)

    #case 4 lance
    elseif unit == "lance"
      return lanceValidate(team,sourcex,sourcey,targetx,targety)

    #case 4.2 promoted lance
    elseif unit == "promotedlance"
      #promotedLance moves same as gold general
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #case 5 knight or Kirin
    elseif unit == "knight"
      return knightValidate(team,sourcex,sourcey,targetx,targety)

    elseif unit == "kirin" && gameType == "chu"
      return kirinValidate(team,sourcex,sourcey,targetx,targety)

    #case 5.2 promoted knight
    elseif unit == "promotedknight"
      #promotedKnight moves same as gold general
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #case 6 pawn
    elseif unit == "pawn"
      return pawnValidate(team,sourcex,sourcey,targetx,targety)

    #case 6.2 promoted pawn
    elseif unit == "promotedpawn"
      #promotedPawn moves same as gold general
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #case 7 rook
    elseif unit == "rook"
      return rookValidate(team,sourcex,sourcey,targetx,targety)

    #case 7.2 promoted rook or dragon king
    elseif unit == "promotedrook"
      return pRookValidate(team,sourcex,sourcey,targetx,targety)

    #case 8 silver general
    elseif unit == "silvergeneral"
      return silverGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #case 8.2 promoted silver general or veritcal mover
    elseif unit == "promotedsilver general"
      #promoted silver general moves same as gold general
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #CHU SHOGI
    #case 9 Reverse Chariot promotes to whale
    elseif unit == "reversechariot" && gameType == "chu"
      return reverseChariotValidate(team,sourcex,sourcey,targetx,targety)

    #case 9.2 whale
    elseif unit == "whale" && gameType == "chu"
      return whaleValidate(team,sourcex,sourcey,targetx,targety)

    #case 10 Copper general promotes to side mover
    elseif unit == "coppergeneral" && gameType == "chu"
      return copperGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #case 11 Dragon King promotes to soaring eagle
    elseif unit == "dragonking" && gameType == "chu"
      return dragonKingValidate(team,sourcex,sourcey,targetx,targety)

    #case 11.2 Soaring eagle
    elseif unit == "soaringeagle" && gameType == "chu"
      return soaringEagleValidate(team,sourcex,sourcey,targetx,targety,targetx2,targety2)

    #case 12 Drunk Elephant promotes to prince
    elseif unit == "drunkelephant" && gameType == "chu"
      return drunkElephantValidate(team,sourcex,sourcey,targetx,targety)

    #case 12.2 prince
    elseif unit == "prince" && gameType == "chu"
      #move like king
      return kingValidate(team,sourcex,sourcey,targetx,targety)

    #case 13 ferocious leopard promotes bishop
    elseif unit == "ferociousleopard" && gameType == "chu"
      return ferociousLeopardValidate(team,sourcex,sourcey,targetx,targety)

    #case 14 Dragon Horse promotes to horned falcon
    elseif unit == "dragonhorse" && gameType == "chu"
      return dragonHorseValidate(team,sourcex,sourcey,targetx,targety)

    #case 14.2 horned falcon
    elseif unit == "hornedfalcon" && gameType == "chu"
      return hornedFalconValidate(team,sourcex,sourcey,targetx,targety,targetx2,targety2)

    #case 15 Lion
    elseif unit == "lion" && gameType == "chu"
      return lionValidate(team,sourcex,sourcey,targetx,targety,targetx2,targety2)

    #case 16 Side Mover promotes to free boar
    elseif unit == "sidemover" && gameType == "chu"
      return sideMoverValidate(team,sourcex,sourcey,targetx,targety)

    #case 16.2 free boar
    elseif unit == "freeboar" && gameType == "chu"
      return freeBoarValidate(team,sourcex,sourcey,targetx,targety)

    #case 17 Go-between promotes to drunk Elephant
    elseif unit == "gobetween" && gameType == "chu"
      return goBetweenValidate(team,sourcex,sourcey,targetx,targety)

    #case 18 Blind tiger promotes to flying stag
    elseif unit == "blindtiger" && gameType == "chu"
      return blindTigerValidate(team,sourcex,sourcey,targetx,targety)

    #case 18.2 flying stag
    elseif unit == "flyingstag" && gameType == "chu"
      return flyingStagValidate(team,sourcex,sourcey,targetx,targety)

    #case 19 Queen
    elseif unit == "queen" && gameType == "chu"
      return queenValidate(team,sourcex,sourcey,targetx,targety)

    #case 20 Vertical Mover promotes to flying ox
    elseif unit == "verticalmover" && gameType == "chu"
      return verticalMoverValidate(team,sourcex,sourcey,targetx,targety)

    #case 20.2
    elseif unit == "flyingox" && gameType == "chu"
      return flyingOxValidate(team,sourcex,sourcey,targetx,targety)

    #case 21 Phoenix promotes to queen
    elseif unit == "phoenix" && gameType == "chu"
      return phoenixValidate(team,sourcex,sourcey,targetx,targety)

    else
      return false #no valid unit
    end
  end

  #moveUpValidate <=== Return true if unit can move veritcally upwards to target ===>
  function moveUpValidate(sourcex, sourcey, targetx, targety)
    if (sourcey != targety)
      return false
    end

    unitCheck = abs(sourcex - targetx) - 1
    x = sourcex - 1
    for unit in 1:unitCheck
      if !((x,targety) in keys(board)) #Empty
        x = x - 1
      else
        return false
      end
    end
    return true
  end #moveUpValidate

  #moveDownValidate <=== Return true if unit can move veritcally downwards to target ===>
  function moveDownValidate(sourcex, sourcey, targetx, targety)
    if (sourcey != targety)
      return false
    end

    unitCheck = abs(sourcex - targetx) - 1
    x = sourcex + 1
    for unit in 1:unitCheck
      if !((x,targety) in keys(board)) #isEmpty
        x = x + 1
      else
        return false
      end
    end

    return true
  end #moveDownValidate

  #moveLeftValidate <=== Return true if unit can move horizontally left to target ===>
  function moveLeftValidate(sourcex, sourcey, targetx, targety)
    if (sourcex != targetx)
      return false
    end

    unitCheck = abs(sourcey - targety) - 1
    y = sourcey - 1
    for unit in 1:unitCheck
      if !((targetx,y) in keys(board)) #isEmpty
        y = y - 1
      else
        return false
      end
    end

    return true
  end #moveLeftValidate

  #moveRightValidate <=== Return true if unit can move horizontally Right to target ===>
  function moveRightValidate(sourcex, sourcey, targetx, targety)
    if (sourcex != targetx)
      return false
    end

    unitCheck = abs(sourcey - targety) - 1
    y = sourcey + 1
    for unit in 1:unitCheck
      if !((targetx,y) in keys(board))
        y = y + 1
      else
        return false
      end
    end

    return true
  end #moveLeftValidate

  #moveOrthogonalValidate <=== Return true if unit can NESW directions ===>
  function moveOrthogonalValidate(sourcex,sourcey,targetx,targety)
    #checks for moves like rook
    if (sourcex == targetx) #horizontal
      if (sourcey < targety) #move right
        if (moveRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #move left
        if (moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    elseif (sourcey == targety) #vertical
      if (sourcex < targetx) #move down
        if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #move up
        if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end

    return false
  end

  #moveAdjacentValidate <=== Return true if unit can move 1 UNIT adjacent ===>
  function moveAdjacentValidate(sourcex,sourcey,targetx,targety)
    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if ((abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0))
        return true
      end
    end

    return false
  end

  #diagonalUpLeft <=== Return true if unit can move diagonally upleft to target ===>
  function diagonalUpLeftValidate(sourcex, sourcey, targetx, targety)
    if (sourcex - targetx) == (sourcey - targety)
      if (sourcex > targetx) #moving diagonal up left
        unitCheck == abs(sourcex - targetx) - 1
        x = sourcex - 1
        y = sourcey - 1
        for unit in 1:unitCheck
          if !((x,y) in keys(board)) #isEmpty
            x = x - 1
            y = y - 1
          else
            return false
          end
        end
        return true
      end
    end

    return false
  end #diagonalUpLeftValidate

  #digonalUpRight <=== Return true if unit can move diagonally upleft to target ===>
  function diagonalUpRightValidate(sourcex, sourcey, targetx, targety)
    if (sourcex - targetx) == (targety - sourcey)
      if (sourcex > targetx) #moving diagonal up right
        unitCheck == abs(sourcex - targetx) - 1
        x = sourcex - 1
        y = sourcey + 1
        for unit in 1:unitCheck
          if !((x,y) in keys(board)) #isEmpty
            x = x - 1
            y = y + 1
          else
            return false
          end
        end
        return true
      end
    end

    return false
  end #diagonalUpRightValidate

  #diagonalDownLeft <=== Return true if unit can move diagonally downleft to target ===>
  function diagonalDownLeftValidate(sourcex, sourcey, targetx, targety)
    if (sourcex - targetx) == (targety - sourcey)
      if (sourcex < targetx) #moving diagonal down left
        unitCheck == abs(sourcex - targetx) - 1
        x = sourcex + 1
        y = sourcey - 1
        for unit in 1:unitCheck
          if !((x,y) in keys(board)) #isEmpty
            x = x + 1
            y = y - 1
          else
            return false
          end
        end
        return true
      end
    end

    return false
  end #diagonalDownLeftValidate

  #diagonalDownRight <=== Return true if unit can move diagonally downright to target ===>
  function diagonalDownRightValidate(sourcex, sourcey, targetx, targety)
    if (sourcex - targetx) == (sourcey - targety)
      if (sourcex < targetx) #moving diagonal down left
        unitCheck == abs(sourcex - targetx) - 1
        x = sourcex + 1
        y = sourcey + 1
        for unit in 1:unitCheck
          if !((x, y) in keys(board)) #isEmpty
            x = x + 1
            y = y + 1
          else
            return false
          end
        end
        return true
      end
    end

    return false
  end #diagonalDownRightValidate

  #moveDiagonalValidate <=== Return true if unit can move diagonally===>
  function moveDiagonalValidate(sourcex, sourcey, targetx, targety)
    #moves like bishop
    if (abs(sourcex - targetx) == abs(sourcey - targety)) #moves diagonally
      if (sourcex < targetx) #downwards
        if (sourcey < targety) #diagonalDownRight
          if (diagonalDownRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #diagonalDownLeft
          if (diagonalDownLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      else #upwards
        if (sourcey < targety) #diagonalUpRightValidate
          if (diagonalUpRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #diagonalUpLeft
          if (diagonalUpLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      end
    end

    return false
  end

  #case 1 #moves diagonally by any
  function bishopValidate(team, sourcex, sourcey, targetx, targety)
    if (moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    #Not moving diagonally
    return false
  end #function bishopValidate end

  #case 1.2 moves like king and bishop
  function pBishopValidate(team,sourcex,sourcey,targetx,targety)

    #checks if it moves like king
    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if ((abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0))
        return true
      end
    end

    #checks moves like normal bishop
    if (moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    return false #does not move like king or bishop
  end #function pBishopValidate end

  # case 2 gold general #moves like king but no diagonal backwards
  function goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #check if it moves like king
    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if (abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0)
        if (team == 'b') #team black
          if (sourcex - targetx == -1) && (sourcey - targety == 1) #bottom left
            return false
          elseif (sourcex - targetx == -1) && (sourcey - targety == -1) #bottom right
            return false
          end
        elseif (team == 'w') #team white
          if (sourcex - targetx == 1) && (sourcey - targety == 1)#top left
            return false
          elseif (sourcex - targetx == 1) && (sourcey - targety == -1) #top right
            return false
          end
        else #invalid team
          return false
        end
        #when it is in either team and not in one of the two units
        return true
      end
    end

    return false #does not move like goldGeneral
  end #goldGeneralValidate

  #case 3 king #moves any by 1
  function kingValidate(team,sourcex,sourcey,targetx,targety)
    if (moveAdjacentValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    return false
  end #kingValidate end

  #case 4 lance #moves forward by any
  #hopping check
  function lanceValidate(team,sourcex,sourcey,targetx,targety)
    if (team == 'b') #team black
      if (targetx < sourcex) && (targety == sourcey)
        if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    elseif (team == 'w') #team white
      if (targetx > sourcex) && (targety == sourcey)
        if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    else
      return false #invalid team
    end

    return false
  end #lanceValidate end

  #case 4.2 promoted lance #moves same as gold general

  #case 5 knight #moves like L
  function knightValidate(team,sourcex,sourcey,targetx,targety)
    if (team == 'b') #team black
      if (sourcex - targetx == 2)
        if (abs(targety - sourcey) == 1)
          return true
        end
      end
    elseif (team == 'w') #team white
      if (sourcex - targetx == -2)
        if (abs(targety - sourcey) == 1)
          return trues
        end
      end
    else #invalid team
      return false
    end

    return false
  end #knigthValidate

  #case 5.2 promoted knight #moves same as gold general

  #case 6 pawn
  function pawnValidate(team,sourcex,sourcey,targetx,targety)
    if (team == 'b') #team black
      if (targetx == sourcex - 1) && (targety == sourcey)
        return true
      end
    elseif (team == 'w') #team white
      if (targetx == sourcex + 1) && (targety == sourcey)
        return true
      end
    else
      return false #invalid team
    end

    return false
  end #pawnValidate end

  #case 6.2 promotedPawn #moves same as gold general

  #case 7 rook
  function rookValidate(team,sourcex,sourcey,targetx,targety)
    #moving horizontally
    if (moveOrthogonalValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    return false
  end #rookValidate end

  #case 7.2 promotedRook #moves like king or normal rook
  function pRookValidate(team,sourcex,sourcey,targetx,targety)
    #checks if it moves like king
    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if ((abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0))
        return true
      end
    end

    #checks if it moves like normal rook
    #moving horizontally
    if (sourcex == targetx) && (sourcey != targety)
      #horizontal left
      if (sourcey > targety)
        if (moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      #horizontal right
      else #(sourcey < targety)
        if (moveRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end

    #moving vertically
    elseif (sourcey == targety) && (sourcex != targetx)
      #vertical up
      if (sourcex > targetx)
        if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      #vertical down
      else #(sourcex < targetx)
        if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end

    return false
  end #pRookValidate end

  #case 8 silverGeneral
  function silverGeneralValidate(team,sourcex,sourcey,targetx,targety)
    res = false
    if (team == 'b') #team black
      if (abs(sourcex - targetx) == 1)
        if (abs(sourcey - targety) == 1 ) #every diagonal corner
          res = true
        elseif (sourcey == targety) && (sourcex == targetx + 1) #up 1
          res = true
        end
      end
    elseif (team == 'w') #team white
      #println("white")
      if (abs(sourcex - targetx) == 1)
        if (abs(sourcey - targety) == 1) #every diagonal corner
          res = true
        elseif (sourcey == targety) && (sourcex == targetx - 1) #down 1
          res = true
        end
      end
    end

    return res
  end #silverGeneralValidate end

  #case 8.2 pSilverGeneral moves same as gold general

  #case 9 reverseChariotValidate
  function reverseChariotValidate(team,sourcex,sourcey,targetx,targety)
    if (sourcey == targety)
      if (sourcex > targetx)
        if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #sourcex < targety
        if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end
    return false
  end #reverseChariotValidate end

  #case 9.2 whale
  function whaleValidate(team,sourcex,sourcey,targetx,targety)

    if (sourcey == targety)
      #moving up
      if (sourcex > targetx)
        if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      #moving down
      else
        if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    elseif (abs(sourcex - targetx) == abs(sourcey - targety)) #diagonal
      if (team == 'b') && (sourcex < targetx)
        if (sourcey < targety) #diagonalDownRight
          if (diagonalDownRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #diagonalDownLeft
          if (diagonalDownLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      elseif (team == 'w') && (sourcex > targetx)
        if (sourcey < targety) #diagonalUpRight
          if (diagonalUpRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #diagonalUpLeft
          if (diagonalUpLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      end
    end

    return false
  end #whaleValidate end

  #case 10 copperGeneralValidate
  function copperGeneralValidate(team,sourcex,sourcey,targetx,targety)
    if (team == 'b')
      if (targetx == sourcex - 1)
        if ((sourcey == targety) || (abs(sourcey - targety) == 1)) #forward any direction by 1
          return true
        end
      elseif (targetx == sourcex + 1)
        if (sourcey == targety) #back 1
          return true
        end
      end
    elseif (team == 'w')
      if (targetx == sourcex + 1)
        if ((sourcey == targety) || (abs(sourcey - targety) == 1)) #forward any direction by 1
          return true
        end
      elseif (targetx == sourcex - 1)
        if (sourcey == targety)
          return true
        end
      end
    end

    return false
  end #copperGeneralValidate end

  #case 10.2 sideMoverValidate
  function sideMoverValidate(team,sourcex,sourcey,targetx,targety)
    if (sourcex == targetx)
      if (sourcey > targety) #moveLeftValidate
        if (moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #moveRightValidate
        if (moveRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    elseif (sourcey == targety)
      if (abs(sourcex - targetx) == 1)
        return true
      end
    end

    return false
  end #sideMoverValidate end

  #case 11 dragonKingValidate #moves like king and rook
  function dragonKingValidate(team,sourcex,sourcey,targetx,targety)
    #checks for moves like king
    if (moveAdjacentValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    #checks for moves like rook
    if (moveOrthogonalValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    return false
  end #dragonKingValidate end

  #case 11.2 Soaring eagle
  function soaringEagleValidate(team,sourcex,sourcey,targetx,targety,targetx2,targety2)
    #range move
    if (isnull(targetx2) && isnull(targety2))

      #moves like rook
      if (sourcex == targetx) && (sourcey != targety) #moving horizontally
        if (sourcey > targety) #horizontal left
          if (moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #horizontal right
          if (moveRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      elseif (sourcey == targety) && (sourcex != targetx) #moving vertically
        if (sourcex > targetx) #vertical up
          if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #vertical down
          if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      end

      #diagonal down
      if (team == 'b')
        if (sourcex < targetx) #move down
          if (sourcey < targety) #move right
            if (diagonalDownRightValidate(sourcex,sourcey,targetx,targety) == true)
              return true
            end
          else #move left
            if (diagonalDownLeftValidate(sourcex,sourcey,targetx,targety) == true)
              return true
            end
          end
        else #move up diagonal 1 or 2
          if (sourcex - targetx == 1) && (abs(sourcey - targety) == 1)
            return true
          elseif (sourcex - targetx == 2) && (abs(sourcey - targety) == 2)
            return true
          end
        end


      elseif (team == 'w')
        if (sourcex > targetx) #move up
          if (sourcey < targety) #move right
            if (diagonalUpRightValidate(sourcex,sourcey,targetx,targety) == true)
              return true
            end
          else #move left
            if (diagonalUpLeftValidate(sourcex,sourcey,targetx,targety) == true)
              return true
            end
          end
        else #move up diagonal 1 or 2
          if (sourcex - targetx == -1) && (abs(sourcey - targety) == 1)
            return true
          elseif (sourcex - targetx == -2) && (abs(sourcey - targety) == 2)
            return true
          end
        end
      end


    else #lion move

      #case 1 capture without movin
      if (sourcex == targetx2 && sourcey == targety2)
        if (team == 'b')
          if ( (sourcex - targetx == 1) && (abs(sourcey - targety) == 1) )
            return true
          end
        elseif (team == 'w')
          if ( (targetx - sourcex == 1) && (abs(sourcey - targety) == 1) )
            return true
          end
        end
      end

      #case 2 eat 1 hop another
      if (team =='b')
        if (sourcex - targetx2 == 2) && (sourcex - targetx == 1)
          if (abs(sourcex - targetx) == 1) && (abs(sourcex - targetx2) == 2)
            return true
          end
        end
      elseif (team == 'w')
        if (targetx2 - sourcex == 2) && (targetx - sourcex == 1)
          if (abs(sourcex - targetx) == 1) && (abs(sourcex - targetx2) == 2)
            return true
          end
        end
      end
    end

    return false
  end #soaringEagleValidate end

  #case 12 drunkElephantValidate
  function drunkElephantValidate(team,sourcex,sourcey,targetx,targety)
    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if ((abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0))
        if (team == 'b')
          if (sourcey == targety) && (targetx == sourcex + 1) #moveback
            return false
          else
            return true
          end
        elseif (team == 'w')
          if (sourcey == targety) && (targetx == sourcex - 1) #moveUp
            return false
          else
            return true
          end
        end
      end
    end

    return false
  end #drunkElephantValidate

  #case 12.2 princeValidate moves like king

  #case 13 ferociousLeopardValidate
  function ferociousLeopardValidate(team,sourcex,sourcey,targetx,targety)
    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if ((abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0))
        if (sourcex != targetx)
          return true
        end
      end
    end

    return false
  end #ferociousLeopardValidate end

  #case 13.2 bishop

  #case 14 dragonHorseValidate
  function dragonHorseValidate(team,sourcex,sourcey,targetx,targety)
    #check for moves like king
    if (moveAdjacentValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    #check for moves like bishop
    if (moveDiagonalValidate(sourcex,sourcey, targetx, targety) == true)
      return true
    end

    return false
  end #dragonHorseValidate end

  #case 14.2 hornedFalconValidate
  function hornedFalconValidate(team,sourcex,sourcey,targetx,targety,targetx2,targety2)

    #range moves
    if isnull(targetx2) && isnull(targety2)

      #check if moves like bishop
      if (moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end

      #Check for vertical down moves and jump 2 forward
      if (sourcey == targety)
        if (team == 'b')
          if (sourcex < targetx)
            if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
              return true
            end
          else #jump 2 up
            if (sourcex - targetx == 2)
              return true
            end
          end
        elseif (team == 'w')
          if (sourcex > targetx)
            if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
              return true
            end
          else #jump 2 down
            if (targetx - sourcex == 2)
              return true
            end
          end
        end
      end

    else #lion moves #where targetx2 and targety2 is NOT null

      #case 2 eats 1 forward without moving
      #case 3 eat 1 forward and then jump 1 forward # not your own team

      if (sourcey == targety)
        if (team == 'b')
          #case 2 eats 1 forward without moving
          if (sourcex == targetx2 && sourcey == targety2)
            if (sourcex == targetx + 1)
              return true
            end
          #case 3 eat 1 forward and then jump 1  forward
          elseif (sourcex == targetx2 + 2)
            if (sourcex == targetx + 1)
              #check if it has an enemy here
              if ((targetx,targety) in keys(board)) && (board[targetx,targety].team == 'w')
                return true
              end
            end
          end
        elseif (team == 'w')
          #case 2 eats 1 forward without moving
          if (sourcex == targetx2 && sourcey == targety2)
            if (sourcex == targetx - 1)
              return true
            end
          #case 3 eat 1 forward and then jump 1  forward
          elseif (sourcex == targetx2 - 2)
            if (sourcex == targetx - 1)
              #check if it has an enemy here
              if ((targetx,targety) in keys(board)) && (board[targetx,targety].team == 'b')
                return true
              end
            end
          end
        end
      end
    end

    return false
  end #hornedFalconValidate end

  #case 15 lionValidate
  function lionValidate(team,sourcex,sourcey,targetx,targety,targetx2,targety2)

    flag2 = false
    if (targetx2 != -1 || targety2 != -1)
      flag2 = true
    end

    #double move
    if flag2 == true
      if (abs(sourcex - targetx) == 1 || abs(sourcex - targetx) == 0) && ((abs(sourcey - targety) == 1) || (abs(sourcey2 - targety) == 0))
        if (abs(targetx2 - targetx) == 1 || abs(targetx2 - targetx) == 0) && ((abs(targety2 - targety) == 1) || (abs(targety2 - targety2) == 0))
          return true
        end
      end

    else
      if (abs(sourcex - targetx) == 2 || abs(soucey - targety) == 2)
        return true
      end
    end

  end #lionValidate end

  #case 16 sideMoverValidate found in case 10.2

  #case 16.2 freeBoarValidate #bishop and side mover
  function freeBoarValidate(team,sourcex,sourcey,targetx,targety)

    #check if moves like bishop
    if (moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    #check if it moves like side mover
    if (sourcex == targetx)
      if (sourcey > targety) #moveLeftValidate
        if (moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #moveRightValidate
        if (moveRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    elseif (sourcey == targety)
      if (abs(sourcex - targetx) == 1)
        return true
      end
    end

    return false
  end #freeBoarValidate end

  #case 17 goBetweenValidate
  function goBetweenValidate(team,sourcex,sourcey,targetx,targety)
    if (sourcey == targety)
      if (abs(sourcey - targety) == 1)
        return true
      end
    end

    return false
  end #goBetweenValidate end

  #case 17.2 drunk elephant  implemented case 12

  #case 18 blindTigerValidate
  function blindTigerValidate(team,sourcex,sourcey,targetx,targety)

    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if ((abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0))
        if (team == 'w')
          if (sourcex != targetx - 1)
            return true #move down 1
          end
        elseif (team == 'b')
          if (sourcex != targetx + 1)
            return true #move up 1
          end
        end
      end
    end

    return false
  end #blindTigerValidate end

  #case 18.2 flygingstagvalidate
  function flyingStagValidate(team,sourcex,sourcey,targetx,targety)
    #moves like king
    if (moveAdjacentValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    #moves like vertical mover
    if (sourcey == targety)
      if ( sourcex < targetx) #move down
        if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #move up
        if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end

    return false
  end #flyingStagValidate end

  #case 19 queenValidate #moves like rook and bhishop
  function queenValidate(team,sourcex,sourcey,targetx,targety)

    #check if moves like bishop
    if (moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    #moves like rook
    if (moveOrthogonalValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    return false
  end #queenValidate end

  #case 20 verticalMoverValidate
  function verticalMoverValidate(team,sourcex,sourcey,targetx,targety)

    #move up and down
    if (sourcey == targety)
      if (sourcex < targetx) #move down
        if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #move up
        if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end

    #left or right by 1
    if (sourcex == targetx)
      if (abs(sourcey - targety) == 1)
        return true
      end
    end

    return false
  end #verticalMoverValidate end

  #case 20.2 flyingOxValidate #moves like bishop and vertical mover
  function flyingOxValidate(team,sourcex,sourcey,targetx,targety)

    #check if moves like bishop
    if (moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
      return true
    end

    #moves like vertical mover
    if (sourcey == targety)
      if (sourcex < targetx) #move down
        if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #move up
        if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end

    #left or right by 1
    if (sourcex == targetx)
      if (abs(sourcey - targety) == 1)
        return true
      end
    end

    return false
  end #flyingOxValidate

  #case 21 Phoenix
  function phoenixValidate(team,sourcex,sourcey,targetx,targety)

    if (abs(sourcex - targetx) == 2) && (abs(sourcey - targety) == 2) #jumps
      return true
    end

    if (sourcex == targetx) #up down left right by 1
      if (abs(sourcey - targety) == 1)
        return true
      end
    elseif (sourcey == targety)
      if (abs(sourcex - targetx) == 1)
        return true
      end
    end

    return false
  end #phoenixValidate end

  #case 21.2 queen implemented case 19

  #case 5 kirinValidate
  function kirinValidate(team,sourcex,sourcey,targetx,targety)

    if (abs(sourcex - targetx) == 1) && (abs(sourcey - targety) == 1) #jumps
      return true
    end

    if (sourcex == targetx) #left or right
      if (abs(sourcey - targety) == 2)
        return true
      end
    elseif (sourcey == targety) #up or down
      if (abs(sourcex - targety) == 2)
        return
      end
    end

    return false
  end #kirinValidate end

  #case 4.2 whiteHorseValidate
  function whiteHorseValidate(team,sourcex,sourcey,targetx,targety)

    if (sourcey == targety)
      #moving up
      if (sourcex > targetx)
        if (moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      #moving down
      else
        if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    elseif (abs(sourcex - targetx) == abs(sourcey - targety)) #diagonal
      if (team == 'w') && (sourcex < targetx)
        if (sourcey < targety) #diagonalDownRight
          if (diagonalDownRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #diagonalDownLeft
          if (diagonalDownLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      elseif (team == 'b') && (sourcex > targetx)
        if (sourcey < targety) #diagonalUpRight
          if (diagonalUpRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #diagonalUpLeft
          if (diagonalUpLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      end
    end

    return false
  end #whiteHorseValidate end

end #validateMod

#<====== MISSING LIONVALIDATE AND LION MOVE FOR SOARING EAGLE =====> #

  maxMove = parse(get(SQLite.query(db, """SELECT max("move_number") from moves;""")[1,1]))
  validSoFar = true
  badMove=0
  metaMove = SQLite.query(db, """SELECT value FROM meta WHERE key = "type" """)
  for x in 1:maxMove #access each row of database
    dataMove = SQLite.query(db, """SELECT move_number, move_type, sourcex, sourcey, targetx, targety, targetx2, targety2, option, i_am_cheating FROM moves WHERE "move_number" = $x""" )
    if (!isnull(dataMove[1,5]) && !isnull(dataMove[1,3]) && !isnull(dataMove[1,6])) #targetx and targety not null

      gameType = get(metaMove[1,1])
      moveType = !isnull(dataMove[1,2]) ? get(dataMove[1,2]) : -1
      sourcex = !isnull(dataMove[1,3]) ? get(dataMove[1,3]) : -1
      sourcey = !isnull(dataMove[1,4]) ? get(dataMove[1,4]) : -1
      targetx = !isnull(dataMove[1,5]) ? get(dataMove[1,5]) : -1
      targety = !isnull(dataMove[1,6]) ? get(dataMove[1,6]) : -1
      targetx2 = !isnull(dataMove[1,7]) ? get(dataMove[1,7]) : -1
      targety2 = !isnull(dataMove[1,8]) ? get(dataMove[1,8]) : -1
      (unitType,team) = get(board,(sourcex,sourcey),('x','x'))
      if (moveValidate(unitType, moveType, gameType, team, sourcex, sourcey, targetx, targety, targetx2, targety2))
        #validSoFar

      else
        validSoFar = false
        badMove=get(dataMove[1,1])
        println(badMove)
      end
      board[(targetx,targety)] = deepcopy(board[(sourcex,sourcey)]) #Updates the board before next move
      delete!(board,(sourcex,sourcey))
    end
end
if !validSoFar #Ensures print only happens at end
  println(badMove)
else
  println(0)
end
