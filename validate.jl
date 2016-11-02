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

include("square.jl")
include("dParse.jl")

  using ST
  using SQLite
  board = ST.loadBoard()
  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile


  #returns True if move is Valid, False otherwise
  function moveValidate(unit, moveType, gameType, team, sourcex, sourcey, targetx, targety)

    #edge 0, sourcex or source y are null but it is not drop
    if ( (isnull(sourcex) || isnull(sourcey)) && moveType != "drop")
      return false
    end

    #edge 1, source and target are the same
    if (sourcex == targetx) && (sourcey == targety)
      return false
    end

    #edge 2, source or target are out of bounds
    if (gameType == "n") #normalShogi
      if  (~(sourcex >= 1 && sourcex <= 9) || ~(sourcey >= 1 && sourcey <= 9) || ~(targetx >= 1 && targetx <= 9) || ~(targety >= 1 && targety <= 9))
        return false
    elseif (gameType == "m") #miniShogi
      if  (~(sourcex >= 1 && sourcex <= 5) || ~(sourcey >= 1 && sourcey <= 5) || ~(targetx >= 1 && targetx <= 5) || ~(targety >= 1 && targety <= 5))
        return false
    elseif (gameType == "c") #chuShogi
      if  (~(sourcex >= 1 && sourcex <= 12) || ~(sourcey >= 1 && sourcey <= 12) || ~(targetx >= 1 && targetx <= 12) || ~(targety >= 1 && targety <= 12))
        return false
    end

    #drop case
    if (moveType == "drop")

      #Chu Shogi has no drops
      if (moveType == "c")
        return false
      end

      #drop case 1: Dropped cannot capture
      if (isEmpty(board[targetx,targety]) == false)
        return false
      end

      #drop case 2: Pawn, Knight, Lance cannot be dropped on the furthest rank
      if (unit == "p" || unit == "n" || unit == "l")
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
      if (unit == 'B' || unit == "L" || unit == "N" || unit == "P" || unit == "R" || unit == "S")
        return false
      end

      #drop case4: Pawns cannot be dropped on the same column as another unpromoted pawn
      if (unit == "p")
        for x in 1:9
          if (board([x,targety]) == "p") #there is a pawn
            return false
          end
        end
      end

      #drop case5: Pawns cannot checkmate #missing

      #drop case6: Capture targets can be dropped #missing

    end

    #case 1 bishop
    if unit == 'b'
      return bishopValidate(team,sourcex,sourcey,targetx,targety)

    #case 1.2 promoted bishop or dragon Horse
    elseif unit == 'B'
      if (gameType == "c")
        return dragonHorseValidate(team,sourcex,sourcey,targetx,targety)
      elseif (gameType == "n")
        return pBishopValidate(team,sourcex,sourcey,targetx,targety)
      end

    #case 2 gold general
    elseif unit == 'g'
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #case 2.3 Chu shogi, gold general promotes to rook
    elseif unit == "G" && gameType == "c"
      return rookValidate(team,sourcex,sourcey,targetx,targety)

    #case 3 king
    elseif unit == 'k'
      return kingValidate(team,sourcex,sourcey,targetx,targety)

    #case 4 lance
    elseif unit == 'l'
      return lanceValidate(team,sourcex,sourcey,targetx,targety)

    #case 4.2 promoted lance or white Horse
    elseif unit == 'L'
      if (gameType == "c'")
        return whiteHorseValidate(team,sourcex,sourcey,targetx,targety)
      elseif (gameType == "n")
      #promotedLance moves same as gold general
        return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)
      end

    #case 5 knight or Kirin
    elseif unit == 'n'
      if (gameType == "c")
        return kirinValidate(team,sourcex,sourcey,targetx,targety)
      elseif (gameType == "n")
        return knightValidate(team,sourcex,sourcey,targetx,targety)
      end

    #case 5.2 promoted knight or kirin
    elseif unit == 'N'
      #kirin promotes to lion
      if (gameType == "c")
        return lionValidate(team,sourcex,sourcey,targetx,targety)
      elseif (gameType == "n")
        #promotedKnight moves same as gold general
        return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)
      end

    #case 6 pawn
    elseif unit == 'p'
      return pawnValidate(team,sourcex,sourcey,targetx,targety)

    #case 6.2 promoted pawn
    elseif unit == 'P'
      #promotedPawn moves same as gold general
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #case 7 rook
    elseif unit == 'r'
      return rookValidate(team,sourcex,sourcey,targetx,targety)

    #case 7.2 promoted rook or dragon king
    elseif unit == 'R'
      if (gameType == "c")
        return dragonKingValidate(team,sourcex,sourcey,targetx,targety)
      elseif (gameType == "n")
        return pRookValidate(team,sourcex,sourcey,targetx,targety)
      end

    #case 8 silver general
    elseif unit == 's'
      return silverGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #case 8.2 promoted silver general or veritcal mover
    elseif unit == 'S'
      if (gameType == "c")
        return verticalMoverValidate(team,sourcex,sourcey,targetx,targety)
      elseif (gameType == "n")
        #promoted silver general moves same as gold general
        return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)
      end

    #CHU SHOGI
    #case 9 Reverse Chariot promotes to whale
    elseif unit == "a" && gameType == "c"
      return reverseChariotValidate(team,sourcex,sourcey,targetx,targety)

    #case 9.2 whale
    elseif unit == "A" && gameType == "c"
      return whaleValidate(team,sourcex,sourcey,targetx,targety)

    #case 10 Copper general promotes to side mover
    elseif unit == "c" && gameType == "c"
      return copperGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #case 10.2 side mover
    elseif unit == "C" && gameType == "c"
      return sideMoverValidate(team,sourcex,sourcey,targetx,targety)

    #case 11 Dragon King promotes to soaring eagle
    elseif unit == "d" && gameType == "c"
      return dragonKingValidate(team,sourcex,sourcey,targetx,targety)

    #case 11.2 Soaring eagle
    elseif unit == "D" && gameType == "c"
      return soaringEagleValidate(team,sourcex,sourcey,targetx,targety)

    #case 12 Drunk Elephant promotes to prince
    elseif unit == "e" && gameType == "c"
      return drunkElephantValidate(team,sourcex,sourcey,targetx,targety)

    #case 12.2 prince
    elseif unit == "E" && gameType == "c"
      return princeValidate(team,sourcex,sourcey,targetx,targety)

    #case 13 ferocious leopard promotes bishop
    elseif unit == "f" && gameType == "c"
      return ferociousLeopardValidate(team,sourcex,sourcey,targetx,targety)

    #case 13.2 bishop
    elseif unit == "F" && gameType == "c"
      return bishopValidate(team,sourcex,sourcey,targetx,targety)

    #case 14 Dragon Horse promotes to horned falcon
    elseif unit == "h" && gameType == "c"
      return dragonHorseValidate(team,sourcex,sourcey,targetx,targety)

    #case 14.2 horned falcon
    elseif unit == "H" && gameType == "c"
      return hornedFalconValidate(team,sourcex,sourcey,targetx,targety)

    #case 15 Lion
    elseif unit == "i" && gameType == "c"
      return lionValidate(team,sourcex,sourcey,targetx,targety)

    #case 16 Side Mover promotes to free boar
    elseif unit == "m" && gameType == "c"
      return sideMoverValidate(team,sourcex,sourcey,targetx,targety)

    #case 16.2 free boar
    elseif unit == "M" && gameType == "c"
      return freeBoarValidate(team,sourcex,sourcey,targetx,targety)

    #case 17 Go-between promotes to drunk Elephant
    elseif unit == "o" && gameType == "c"
      return goBetweenValidate(team,sourcex,sourcey,targetx,targety)

    #case 17.2 drunk elephant
    elseif unit == "O" && gameType == "c"
      return drunkElephantValidate(team,sourcex,sourcey,targetx,targety)

    #case 18 Blind tiger promotes to flying stag
    elseif unit == "t" && gameType == "c"
      return blindTigerValidate(team,sourcex,sourcey,targetx,targety)

    #case 18.2 flying stag
    elseif unit == "T" && gameType == "c"
      return flyingStagValidate(team,sourcex,sourcey,targetx,targety)

    #case 19 Queen
    elseif unit == "q" && gameType == "c"
      return queenValidate(team,sourcex,sourcey,targetx,targety)

    #case 20 Vertical Mover promotes to flying ox
    elseif unit == "v" && gameType == "c"
      return verticalMoverValidate(team,sourcex,sourcey,targetx,targety)

    #case 20.2
    elseif unit == "V" && gameType == "c"
      return flyingOxValidate(team,sourcex,sourcey,targetx,targety)

    #case 21 Phoenix promotes to queen
    elseif unit == "x" && gameType == "c"
      return phoenixValidate(team,sourcex,sourcey,targetx,targety)

    #case 21.2
    elseif unit == "X" && gameType == "c"
      return queenValidate(team,sourcex,sourcey,targetx,targety)

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
      if (isEmpty(board[x,sourcey]) == true)
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
      if (isEmpty(board[x,sourcey]) == true)
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
      if (isEmpty(board[sourcex,y]) == true)
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
      if (isEmpty(board[sourcex,y]) == true)
        y = y + 1
      else
        return false
      end
    end

    return true
  end #moveLeftValidate

  #diagonalUpLeft <=== Return true if unit can move diagonally upleft to target ===>
  function diagonalUpLeftValidate(sourcex, sourcey, targetx, targety)
    if (sourcex - targetx) == (sourcey - targety)
      if (sourcex > targetx) #moving diagonal up left
        unitCheck == abs(sourcex - targetx) - 1
        x = sourcex - 1
        y = sourcey - 1
        for unit in 1:unitCheck
          if (isEmpty(board[x,y]) == true)
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
          if (isEmpty(board[x,y]) == true)
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
          if (isEmpty(board[x,y]) == true)
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

  #diagonalDownRight
  function diagonalDownRightValidate(sourcex, sourcey, targetx, targety)
    if (sourcex - targetx) == (sourcey - targety)
      if (sourcex < targetx) #moving diagonal down left
        unitCheck == abs(sourcex - targetx) - 1
        x = sourcex + 1
        y = sourcey + 1
        for unit in 1:unitCheck
          if (isEmpty(board[x,y]) == true)
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

  #case 1 #moves diagonally by any
  function bishopValidate(team, sourcex, sourcey, targetx, targety)
    if (abs(sourcex - targetx) == abs(sourcey - targety)) #moves diagonally

      #SW x increase, y decreases
      if (sourcex < targetx) && (sourcey > targety)
        if (diagonalDownLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
        end
      #SE x increases, y increases
      elseif (sourcex < targetx) && (sourcey < targety)
        if (diagonalDownRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
        end
      #NW x decreases, y decreases
      elseif (sourcex > targetx) && (sourcey > targety)
        if (diagonalUpLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
        end
      #NE x decreases, y increases
      elseif (sourcex > targetx) && (sourcey < targety)
        if (diagonalUpRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
        end
      end
    end

    #Not moving diagonally
    return false
  end #function bishopValidate end

  #case 1.2 moves like king and bishop
  function pBishopValidate(team,sourcex,sourcey,targetx,targety)

    #checks if it moves like king
    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if (abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0)
        return true
      end

    #checks moves like normal bishop
    elseif (abs(sourcex - targetx) == abs(sourcey - targety)) #moves diagonally

      #SW x increase, y decreases
      if (sourcex < targetx) && (sourcey > targety)
        if (diagonalDownLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
        end
      #SE x increases, y increases
      elseif (sourcex < targetx) && (sourcey < targety)
        if (diagonalDownRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
        end
      #NW x decreases, y decreases
      elseif (sourcex > targetx) && (sourcey > targety)
        if (diagonalUpRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
        end
      #NE x decreases, y increases
      elseif (sourcex > targetx) && (sourcey < targety)
        if (diagonalUpLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
        end
      end
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
    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if ((abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0))
        return true
      end
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
    #doesn't care about teams #4 cases #moving horizontally to left or right #moving vertically to up or down

    #moving horizontally
    if (sourcex == targetx) && (sourcey != targety)
      #horizontal left
      if (sourcey > targety)
        if (moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      #horizontal right
      else
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
      else
        if (moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
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

    #checks if it moves like normal rook

    #moving horizontally
    elseif (sourcex == targetx) && (sourcey != targety)
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
      println("white")
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

  #<=== dragonHorseValidate, whiteHorseValidate, kirinValidate, lionValidate, dragonKingValidate,verticalMoverValidate ===>#

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
    else if (abs(sourcex - targetx) == abs(sourcey - targety)) #diagonal
      if (team == "b") && (sourcex < targetx)
        if (sourcey < targety) #diagonalDownRight
          if (diagonalDownRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #diagonalDownLeft
          if (diagonalDownLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      elseif (team == "w") && (sourcex > targetx)
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


  maxMove = get(SQLite.query(db, """SELECT max("move_number") from moves;""")[1,1])
  validSoFar = true
  badMove=0
  for x in 1:maxMove #access each row of database
    dataMove = SQLite.query(db, """SELECT move_number, move_type, sourcex, sourcey, targetx, targety, option, i_am_cheating FROM moves WHERE "move_number" = $x""" )
    if (!isnull(dataMove[1,5]) && !isnull(dataMove[1,3]) && !isnull(dataMove[1,6])) #targetx and targety not null

      sourcex = get(dataMove[1,3])
      sourcey = get(dataMove[1,4])
      targetx = get(dataMove[1,5])
      targety = get(dataMove[1,6])
      moveType = get(dataMove[1,2])
      unitType = board[sourcex,sourcey].piece

      if (moveValidate(unitType, moveType, board[sourcex,sourcey].team, sourcex, sourcey, targetx, targety))
        #validSoFar

      else
        validSoFar = false
        badMove=get(dataMove[1,1])
        println(badMove)
      end
      board[targetx,targety].piece = board[sourcex,sourcey].piece #Updates the board before next move
      board[targetx,targety].team = board[sourcex,sourcey].team
      ST.clear!(board[sourcex,sourcey])
    end
end
if !validSoFar #Ensures print only happens at end
  println(badMove)
else
  println(0)
end
