#=validate.jl - replay the game from start to the current move, at every step making
sure that the rules were kept. Print 0 is the game was played cleanly so far and the move ID
of the violating move if it wasn’t. Accepts 1 command line argument,<filename> => database
=#

module validate

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile


  # dictionary has potential problems, also need promotions
  gamePiece = Dict("b" => "Bishop", "g" => "Gold General", "k" => "King", "l" => "Lance", "n" => "Knight", "p" => "Pawn", "r" => "Rook", "s" => "Silver General")

  maxMove = SQLite.query(db, "SELECT max(move_number)")

  for x in 1:maxMove
    #access each row of database
    dataMove = SQLite.query(db, "SELECT move_number, move_type, sourcex, sourcey, targetx, targety, option, i_am_cheating FROM moves WHERE move_number = $x" )
     if ( !isnull(dataMove[1][3]) && !isnull(dataMove[1][4]) && !isnull(dataMove[1][5]) && !isnull(dataMove[1][6]) )
       sourcex = get(dataMove[1][3])
       sourcey = get(dataMove[1][4])
       targetx = get(dataMove[1][5])
       targety = get(dataMove[1][6])
       unitType = board[sourcex][sourcey].piece
     moveValidate(unitType, board[sourcex][sourcey].team, sourcex, sourcey, targetx, targety)
  end


  #returns True if move is Valid, False otherwise
  #unit refers to gamePiece, team refers to black player or white player, sourcex and sourcey is current position of unit
  function moveValidate(unit, team, sourcex, sourcey, targetx, targety)
  #None of the pieces, except the knight, may jump over another piece as it moves.
  #Dropping restriction

    #edge 1, source and target are the same
    if (sourcex == targetx) && (sourcey == targety)
      return false
    end

    #edge 2, source or target are out of bounds
    if  (~(sourcex >= 1 && sourcex <= 9) || ~(sourcey >= 1 && sourcey <= 9) || ~(targetx >= 1 && targetx <= 9) || ~(targety >= 1 && targety <= 9))
      return false #out of bounds
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
      return pLanceValidate(team,sourcex,sourcey,targetx,targety)

    #case 5 knight
    elseif unit == "n"
      return knightValidate(team,sourcex,sourcey,targetx,targety)

    #case 5.2 promoted knight
    elseif unit == "N"
      return pKnightValidate(team,sourcex,sourcey,targetx,targety)

    #case 6 pawn
    elseif unit == "p"
      return pawnValidate(team,sourcex,sourcey,targetx,targety)

    #case 6.2 promoted pawn
    elseif unit == "P"
      return pPawnValidate(team,sourcex,sourcey,targetx,targety)

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
      return pSilverGeneralValidate(team,sourcex,sourcey,targetx,targety)

    else
      return false
    end

  end


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
        for unit in 1:unitCheck - 1
          if (isEmpty(board[x][y]) == true)
            x = x + 1
            y = y - 1
          else #there is a piece in its path
            return false
          end
        end

      #SE x increases, y increases
      if (sourcex < targetx) && (sourcey < targety)
        x = sourcex + 1
        y = sourcey + 1
        for unit in 1:unitCheck - 1
          if (isEmpty(board[x][y]) == true)
            x = x + 1
            y = y + 1
          else #there is a piece in its path
            return false
          end
        end

      #NW x decreases, y decreases
      if (sourcex > targetx) && (sourcey > targety)
        x = sourcex - 1
        y = sourcey - 1
        for unit in 1:unitCheck - 1
          if (isEmpty(board[x][y]) == true)
            x = x - 1
            y = y - 1
          else #there is a piece in its path
            return false
          end
        end

      #NE x decreases, y increases
      if (sourcex > targetx) && (sourcey < targety)
        x = sourcex - 1
        y = sourcey + 1
        for unit in 1:unitCheck - 1
          if (isEmpty(board[x][y]) == true)
            x = x - 1
            y = y + 1
          else #there is a piece in its path
            return false
          end
        end

      #Nothing is blocking its path, return true for validmove
      return true
    end


  function pbishopvalid(team, sourcex, sourcey, targetx, targety)

    end


  function pbishopvalid(team, sourcex, sourcey, targetx, targety)

    if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
      if ((abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0))
        if (team == "black")
          if (targetx - sourcex == -1) && (targety - sourcey == 1) #bottom left
            return false
          elseif (targetx - sourcex == 1) && (targety- sourcey == 1) #bottom right
            return false
          else
            return true
          end
        elseif (team == "white")
          if (targetx - sourcex == -1) && (targety - sourcey == -1) #top left
            return false
          elseif (targetx -sourcex == 1) && (targety - sourcey == -1) #top right
            return false
          else
            return true
        end
      end
    end
  end



end
