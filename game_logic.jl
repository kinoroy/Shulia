module game_logic

  using SQLite

  database = ARGS[1] #/path/to/database/file {string}
  SQLite.connect(database) #Opens the database gamefile

  gamePiece = Dict("b" => "Bishop", "g" => "Gold General", "k" => "King", "l" => "Lance", "n" => "Knight", "p" => "Pawn", "r" => "Rook", "s" => "Silver General")


  #returns True if move is Validate, False otherwise
  #unit refers to gamePiece, team refers to black player or white player, sourcex and sourcey is current position of unit
  function moveValidate(unit, team, sourcex, sourcey, targetx, targety)

    #case 1 = Bishop

    #case 2 = Gold General

    #case 3 = King

    #case 4 = Lance

    #case 5 = Knight

    #case 6 = Pawn
    elseif (unit == "p")
      if (team == "black")
        if (sourcex > 1 && sourcex <= 9)
          if ((targetx == sourcex + 1) && (targety == sourcey))
            return true
          else
            return false #invalid move
          end
        else
          return false #sourcex == 1
        end
      elseif (team == "white")
        if (sourcex >= 1 && sourcex < 9)
          if ((targetx == sourcex - 1) && (targety == sourcey))
            return true
          else
            return false #invalid move
          end
        else
          return false #sourcex == 9
        end
      else
        return false #invalid team
      end

    #case 7 = Rook

    #case 8 = Silver General


  end

end
