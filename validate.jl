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
  #unit refers to gamePiece, team refers to black player or white player, sourcex and sourcey is current position of unit
  function moveValidate(unit, moveType, team, sourcex, sourcey, targetx, targety)
    #None of the pieces, except the knight, may jump over another piece as it moves.
    #Dropping restriction

    #edge 0, sourcex or source y are null but it is not drop
    if ( (isnull(sourcex) || isnull(sourcey)) && moveType != "drop")
      return false
    end

    #edge 1, source and target are the same
    if (sourcex == targetx) && (sourcey == targety)
      return false
    end

    #edge 2, source or target are out of bounds
    if  (~(sourcex >= 1 && sourcex <= 9) || ~(sourcey >= 1 && sourcey <= 9) || ~(targetx >= 1 && targetx <= 9) || ~(targety >= 1 && targety <= 9))
      return false #out of bounds
    end

    #drop case
    if (moveType == "drop")

      #drop case 1: Dropped cannot capture
      if (isEmpty(board[targetx][targety]) == false)
        return false
      end

      #drop case 2: Pawn, Knight, Lance cannot be dropped on the furthest rank
      if (unit == "p" || unit == "n" || unit == "l")
        if (team == "b") #team black
          if (targetx == 1)
            return false
          end
        elseif (team =="w") #team white
          if (targetx == 9)
            return false
          end
        end
      end

      #drop case3: It is not promoted
      if (unit == "B" || unit == "L" || unit == "N" || unit == "P" || unit == "R" || unit == "S")
        return false
      end

      #drop case4: Pawns cannot be dropped on the same column as another unpromoted pawn
      #drop case5: Pawns cannot checkmate #missing
      if (unit == "p")
        for x in 1:9
          if (board([x][targety]) == "p") #there is a pawn
            return false
          end
        end
      end

      #drop case6: Capture targets can be dropped #missing

    end

    #case 1 bishop
    if unit == "b"
      return bishopValidate(team,sourcex,sourcey,targetx,targety)

      #case 1.2 promoted bishop
    elseif unit == "B"
      return pBishopValidate(team,sourcex,sourcey,targetx,targety)

      #case 2 gold general
    elseif unit == "g"
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

      #case 3 king
    elseif unit == "k"
      return kingValidate(team,sourcex,sourcey,targetx,targety)

      #case 4 lance
    elseif unit == "l"
      return lanceValidate(team,sourcex,sourcey,targetx,targety)

      #case 4.2 promoted lance
    elseif unit == "L"
      #promotedLance moves same as gold general
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

      #case 5 knight
    elseif unit == "n"
      return knightValidate(team,sourcex,sourcey,targetx,targety)

      #case 5.2 promoted knight
    elseif unit == "N"
      #promotedKnight moves same as gold general
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

      #case 6 pawn
    elseif unit == "p"
      return pawnValidate(team,sourcex,sourcey,targetx,targety)

      #case 6.2 promoted pawn
    elseif unit == "P"
      #promotedPawn moves same as gold general
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

      #case 7 rook
    elseif unit == "r"
      return rookValidate(team,sourcex,sourcey,targetx,targety)

      #case 7.2 promoted rook
    elseif unit == "R"
      return pRookValidate(team,sourcex,sourcey,targetx,targety)

      #case 8 silver general
    elseif unit == "s"
      return silverGeneralValidate(team,sourcex,sourcey,targetx,targety)

      #case 8.2 promoted silver general
    elseif unit == "S"
      #promoted silver general moves same as gold general
      return goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

    else
      return false #no valid unit
    end

  end

  #case 1
  function bishopValidate(team, sourcex, sourcey, targetx, targety)
    #moves diagonally by any
    #missing jumping restrictions, validation
    if (abs(sourcex - targetx) == abs(sourcey - targety))

      #code below checks for jumping restrictions
      #checks the units between source and target unit and if there is a unit between it
      unitCheck = abs(sourcex - targetx) #unitCheck is the number of units from source to target to check for

      #SW x increase, y decreases
      if (sourcex < targetx) && (sourcey > targety)
        x = sourcex + 1
        y = sourcey - 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][y]) == true)
            x = x + 1
            y = y - 1
          else #there is a piece in its path
            return false
          end
        end

        #SE x increases, y increases
      elseif (sourcex < targetx) && (sourcey < targety)
        x = sourcex + 1
        y = sourcey + 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][y]) == true)
            x = x + 1
            y = y + 1
          else #there is a piece in its path
            return false
          end
        end

        #NW x decreases, y decreases
      elseif (sourcex > targetx) && (sourcey > targety)
        x = sourcex - 1
        y = sourcey - 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][y]) == true)
            x = x - 1
            y = y - 1
          else #there is a piece in its path
            return false
          end
        end

        #NE x decreases, y increases
      elseif (sourcex > targetx) && (sourcey < targety)
        x = sourcex - 1
        y = sourcey + 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][y]) == true)
            x = x - 1
            y = y + 1
          else #there is a piece in its path
            return false
          end
        end
      end
        #Nothing is blocking its path, return true for validmove
      return true
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
    elseif (abs(sourcex - targetx) == abs(sourcey - targety))
      unitCheck = abs(sourcex - targetx) #unitCheck is the number of units from source to target to check for

      #SW x increase, y decreases
      if (sourcex < targetx) && (sourcey > targety)
        x = sourcex + 1
        y = sourcey - 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][y]) == true)
            x = x + 1
            y = y - 1
          else #there is a piece in its path
            return false
          end
        end

      #SE x increases, y increases
      elseif (sourcex < targetx) && (sourcey < targety)
        x = sourcex + 1
        y = sourcey + 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][y]) == true)
            x = x + 1
            y = y + 1
          else #there is a piece in its path
            return false
          end
        end

      #NW x decreases, y decreases
      elseif (sourcex > targetx) && (sourcey > targety)
        x = sourcex - 1
        y = sourcey - 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][y]) == true)
            x = x - 1
            y = y - 1
          else #there is a piece in its path
            return false
          end
        end

      #NE x decreases, y increases
      elseif (sourcex > targetx) && (sourcey < targety)
        x = sourcex - 1
        y = sourcey + 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][y]) == true)
            x = x - 1
            y = y + 1
          else #there is a piece in its path
            return false
          end
        end
      end
      return true
    end

    return false #does not move like king or bishop
  end #function pBishopValidate end

  # case 2 gold general #moves like king but no diagonal backwards
  function goldGeneralValidate(team,sourcex,sourcey,targetx,targety)

    #check if it moves like king
    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if (abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0)
        if (team == "b") #team black
          if (sourcex - targetx == -1) && (sourcey - targety == 1) #bottom left
            return false
          elseif (sourcex - targetx == -1) && (sourcey - targety == -1) #bottom right
            return false
          end
        elseif (team == "w") #team white
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
    if (team == "b") #team black
      if (targetx < sourcex) && (targety == sourcey)

        #it is confirmed that it moves up but need to check jumping restrictions
        #jumping restriction = checking if path between source and target is occupied
        unitCheck = sourcex - targetx #how many units it advances
        x = sourcex - 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][sourcey] == true))
            x = x - 1
          else
            return false
          end
        end

        #passes jumping test
        return true
      end
    elseif (team == "w") #team white
      if (targetx > sourcex) && (targety == sourcey)

        #jumping restriction
        unitCheck = targetx - sourcex
        x = sourcex + 1
        for unit in 1:(unitCheck -1)
          if (isEmpty(board[x][sourcey] == true))
            x = x + 1
          else
            return false
          end
        end

        #passes jumping test
        return true
      end
    else
      return false #invalid team
    end

    return false
  end #lanceValidate end

  #case 4.2 promoted lance #moves same as gold general

  #case 5 knight #moves like L
  function knightValidate(team,sourcex,sourcey,targetx,targety)
    if (team == "b") #team black
      if (sourcex - targetx == 2)
        if (abs(targety - sourcey) == 1)
          return true
        end
      end
    elseif (team == "w") #team white
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
    if (team == "b") #team black
      if (targetx == sourcex - 1) && (targety == sourcey)
        return true
      end
    elseif (team == "w") #team white
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
      unitCheck = abs(sourcey - targety)
      #horizontal left
      if (sourcey > targety)
        y = sourcey - 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[sourcex][y] == true))
            y = y - 1
          else
            return false
          end
        end
      #horizontal right
      else #(sourcey < targety)
        y = sourcey + 1
        for unit in 1:(unitCheck -1)
          if (isEmpty(board[sourcex][y] == true))
            y = y + 1
          else
            return false
          end
        end
      end

    #moving vertically
    elseif (sourcey == targety) && (sourcex != targetx)
      unitCheck = abs(sourcex - targetx)
      #vertical up
      if (sourcex > targetx)
        x = sourcex - 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][sourcey] == true))
            x = x - 1
          else
            return false
          end
        end
      #vertical down
      else #(sourcex < targetx)
        x = sourcex + 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][sourcey] == true))
            x = x + 1
          else
            return false
          end
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
      unitCheck = abs(sourcey - targety)
      #horizontal left
      if (sourcey > targety)
        y = sourcey - 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[sourcex][y] == true))
            y = y - 1
          else
            return false
          end
        end
      #horizontal right
      else #(sourcey < targety)
        y = sourcey + 1
        for unit in 1:(unitCheck -1)
          if (isEmpty(board[sourcex][y] == true))
            y = y + 1
          else
            return false
          end
        end
      end

    #moving vertically
    elseif (sourcey == targety) && (sourcex != targetx)
      unitCheck = abs(sourcex - targetx)
      #vertical up
      if (sourcex > targetx)
        x = sourcex - 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][sourcey] == true))
            x = x - 1
          else
            return false
          end
        end
      #vertical down
      else #(sourcex < targetx)
        x = sourcex + 1
        for unit in 1:(unitCheck - 1)
          if (isEmpty(board[x][sourcey] == true))
            x = x + 1
          else
            return false
          end
        end
      end
    end

    return false
  end #pRookValidate end

  #case 8 silverGeneral
  function silverGeneralValidate(team,sourcex,sourcey,targetx,targety)
    if (team == "b") #team black
      if (abs(sourcex - targetx) == 1)
        if (abs(sourcey - targety) == 1 ) #every diagonal corner
          return true
        elseif (sourcey == targety) && (sourcex == targetx + 1) #up 1
          return true
        end
      end
    elseif (team == "w") #team white
      if (abs(sourcex - targetx) == 1)
        if (abs(sourcey - targety) == 1) #every diagonal corner
          return true
        elseif (sourcey == targety) && (sourcex == targetx - 1) #down 1
          return true
        end
      end
    else
      return false #invalid team
    end

    return false
  end #silverGeneralValidate end

  #case 8.2 pSilverGeneral moves same as gold general


  maxMove = get(SQLite.query(db, """SELECT max("move_number") from moves;""")[1,1])
  validSoFar = true
  badMove=0
  for x in 1:maxMove #access each row of database
    dataMove = SQLite.query(db, """SELECT move_number, move_type, sourcex, sourcey, targetx, targety, option, i_am_cheating FROM moves WHERE "move_number" = $x""" )
    if (!isnull(dataMove[1,5]) && !isnull(dataMove[1,6])) #targetx and targety not null
      sourcex = get(dataMove[1,3])
      sourcey = get(dataMove[1,4])
      targetx = get(dataMove[1,5])
      targety = get(dataMove[1,6])
      moveType = get(dataMove[1,2])
      unitType = board[sourcex,sourcey].piece
      if (moveValidate(unitType, moveType, board[sourcex,sourcey].team, sourcex, sourcey, targetx, targety) == true)
        #validSoFar
      else
        validSoFar = false
        badMove=get(dataMove[1,1])
      end
    end
    board[targetx,targety].piece = board[sourcex,sourcey].piece #Updates the board before next move
    board[targetx,targety].team = board[sourcex,sourcey].team
    ST.clear!(board[sourcex,sourcey])
end
if !validSoFar #Ensures print only happens at end
  println(badMove)
else
  println(0)
end
