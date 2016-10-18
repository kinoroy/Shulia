module game_logic

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  db = SQLite.DB(database) #Opens the database gamefile

  gamePiece = Dict("b" => "Bishop", "g" => "Gold General", "k" => "King", "l" => "Lance", "n" => "Knight", "p" => "Pawn", "r" => "Rook", "s" => "Silver General")


  #returns True if move is Valid, False otherwise
  #unit refers to gamePiece, team refers to black player or white player, sourcex and sourcey is current position of unit
  function moveValidate(unit, team, sourcex, sourcey, targetx, targety)
    #None of the pieces, except the knight, may jump over another piece as it moves.
    #Promotion restrictions
    #Dropping restrictions

    #edge 1, source and target are the same
    if (sourcex == targetx) && (sourcey == targety)
      return false

    #edge 2, source or target are out of bounds
    if  (~(sourcex >= 1 && sourcex <= 9) || ~(sourcey >= 1 && sourcey <= 9) || ~(targetx >= 1 && targetx <= 9) || ~(targety >= 1 && targety <= 9))
      return false #out of bounds

    #case 1 = Bishop #moves diagonally by any
    #missing jumping restrictions
    if (unit = "b")
      if (abs(sourcex - targetx) == abs(sourcey - targety))
        return true

    #case 2 = Gold General
    elseif (unit = "g")
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

    #case 3 = King #moves any surrounding by 1
    elseif (unit == "k")
      if ((abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0))
        if ((abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0))
          return true
        end
      end

    #case 4 = Lance #moves up by any
    #missing jumping restrictions
    elseif (unit == "l")
      if (team == "black")
        if (sourcex > 1 && sourcex <= 9)
          if ((targetx > sourcex) && (targety == sourcey))
              return true
          end
        end
      elseif (team == "white")
        if (sourcex >= 1 && sourcex < 9)
          if ((targetx < sourcex) && (targety == sourcey))
            return true
          end
        end
      end

    #case 5 = Knight
    elseif (unit == "n")
      if (team == "black")
        if (sourcex - targetx == 2)
          if (abs(targety - sourcey == 1))
            return true
          end
        end
      else if (team == "white")
        if (sourcex - targetx == -2)
          if (abs(targety - sourcey == 1))
            return true
          end
        end
      end

    #case 6 = Pawn #moves up by 1
    elseif (unit == "p")
      if (team == "black")
        if (sourcex > 1 && sourcex <= 9)
          if ((targetx == sourcex + 1) && (targety == sourcey))
            return true
          end
        end
      elseif (team == "white")
        if (sourcex >= 1 && sourcex < 9)
          if ((targetx == sourcex - 1) && (targety == sourcey))
            return true
          end
        end
      end

    #case 7 = Rook #orthogonally by any
    #missing jumping restrictions
    elseif (unit == "r")
      if (targetx == sourcex)
        if (targety != sourcey)
          return true
        end
      else
        if (targety == sourcey)
          return true
        end
      end

    #case 8 = Silver General
    else if (unit == "s")
      if (team == "black")
        if (abs(targetx - sourcex == 1))
          if (targety - sourcey == 1)
            return false #move back 1
          else
            return true
          end
        end
      elseif (team == "white")
        if (abs(targetx - sourcex == 1))
          if (targety - sourcey == -1)
            return false #move back 1
          else
            return true
          end
        end
      end
    end

    return false
  end #function end

end #module end
