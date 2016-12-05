#include("square.jl")
include("dparse.jl")
include("validate.jl") #for pre-existing functions types
include("board.jl")

#==== TO DO LIST ===#
#1. unit functions
#2. edge cases
#3. review each unit functions see if the function parameters matches and if the logic makes sense

import validateMod
using ST #square.jl module
using SQLite


board = ST.loadBoard()
database = ARGS[1] #path/to/databasefile {string}
db = SQLite.DB(database) #opens database gamefile

#returns True if move is valid in Tenjiku Shogi
function tenjikuMoveValidate(unit, moveType, team, sourcex, sourcey, targetx, targety, targetx2, targety2, targetx2, targetx3)

  #edge 1: no dropping
  if (moveType == "drop")
    return false
  end

  #case 1
  if (unit == "jeweledgeneral")
    return validateMod.kingValidate(team, sourcex, sourcey, targetx, targety)

  #case 2
  elseif (unit == "prince")
    return validateMod.kingValidate(team, sourcex, sourcey, targetx, targety)

  #case 3
  elseif (unit == "kinggeneral")
    return validateMod.kingValidate(team, sourcex, sourcey, targetx, targety)

  #case 4
  elseif (unit == "drunkelephant")
    return validateMod.drunkElephantValidate(team, sourcex, sourcey, targetx, targety)

      #case 5
  elseif (unit == "vicegeneral")
    return viceGeneralValidate(team, sourcex, sourcey, targetx, targety, targetx2, targety2, targetx3, targety3)

      #case 6
  elseif (unit == "greatgeneral")
    return greatGeneralValidate(team, sourcex, sourcey, targetx, targety)

      #case 7
  elseif (unit == "bishopgeneral")
    return bishopGeneralValidate(team, sourcex, sourcey, targetx, targety)

      #case 8
  elseif (unit == "rookgeneral")
    return rookGeneralValidate(team, sourcex, sourcey, targetx, targety)

      #case 9
  elseif (unit == "hornedfalcon")
    return validateMod.hornedFalconValidate(team, sourcex, sourcey, targetx, targety)

      #case 10
  elseif (unit == "soaringeagle")
    return validateMod.soaringEagleValidate(team, sourcex, sourcey, targetx, targety)

      #case 11
  elseif (unit == "dragonhorse")
    return validateMod.dragonHorseValidate(team, sourcex, sourcey, targetx, targety)

      #case 12
  elseif (unit == "dragonking")
    return validateMod.dragonKingValidate(team, sourcex, sourcey, targetx, targety)

      #case 13
  elseif (unit == "bishop")
    return validateMod.bishopValidate(team, sourcex, sourcey, targetx, targety)

      #case 14
  elseif (unit == "rook")
    return validateMod.rookValidate(team, sourcex, sourcey, targetx, targety)

      #case 15
  elseif (unit == "ferociousleopard")
    return validateMod.ferociousLeopardValidate(team, sourcex, sourcey, targetx, targety)

      #case 16
  elseif (unit == "goldgeneral")
    return validateMod.goldGeneralValidate(team, sourcex, sourcey, targetx, targety)

      #case 17
  elseif (unit == "pawn")
    return validateMod.pawnValidate(team, sourcex, sourcey, targetx, targety)

      #case 18
  elseif (un18t == "firedemon")
    return fireDemonValidate(team, sourcex, sourcey, targetx, targety)

      #case 19
  elseif (unit == "heavenlytetrarch")
    return heavenlyTetrarchValidate(team, sourcex, sourcey, targetx, targety)

      #case 20
  elseif (unit == "waterbuffalo")
    return waterBuffaloValidate(team, sourcex, sourcey, targetx, targety)

      #case 21
  elseif (unit == "chariotSoldier")
    return chariotSoldierValidate(team, sourcex, sourcey, targetx, targety)

      #case 22
  elseif (unit == "sidesoldier")
    return sideSoldierValidate(team, sourcex, sourcey, targetx, targety)

      #case 23
  elseif (unit == "verticalsoldier")
    return verticalSoldierValidate(team, sourcex, sourcey, targetx, targety)

      #case 24
  elseif (unit == "knight")
    return validateMod.knightValidate(team, sourcex, sourcey, targetx, targety)

      #case 25
  elseif (unit == "irongeneral")
    return ironGeneralValidate(team, sourcex, sourcey, targetx, targety)

      #case 26
  elseif (unit == "freeeagle")
    return freeEagleValidate(team, sourcex, sourcey, targetx, targety)

      #case 27
  elseif (unit == "lionhawk")
    return lionHawkValidate(team, sourcex, sourcey, targetx, targety)

      #case 28
  elseif (unit == "queen")
    return validateMod.queenValidate(team, sourcex, sourcey, targetx, targety)

      #case 29
  elseif (unit == "lion")
    return validateMod.lionValidate(team, sourcex, sourcey, targetx, targety)

      #case 30
  elseif (unit == "phoenix")
    return validateMod.phoenixValidate(team, sourcex, sourcey, targetx, targety)

      #case 31
  elseif (unit == "kirin")
    return validateMod.kirinValidate(team, sourcex, sourcey, targetx, targety)

      #case 32
  elseif (unit == "freeboar")
    return validateMod.freeBoarValidate(team, sourcex, sourcey, targetx, targety)

      #case 33
  elseif (unit == "flyingox")
    return validateMod.flyingOxValidate(team, sourcex, sourcey, targetx, targety)

      #case 34
  elseif (unit == "sidemover")
    return validateMod.sideMoverValidate(team, sourcex, sourcey, targetx, targety)

      #case 35
  elseif (unit == "verticalmover")
    return validateMod.verticalMoverValidate(team, sourcex, sourcey, targetx, targety)

      #case 36
  elseif (unit == "coppergeneral")
    return validateMod.copperGeneralValidate(team, sourcex, sourcey, targetx, targety)

      #case 37
  elseif (unit == "silvergeneral")
    return validateMod.silverGeneralValidate(team, sourcex, sourcey, targetx, targety)

      #case 38
  elseif (unit == "multigeneral")
    return multiGeneralValidate(team, sourcex, sourcey, targetx, targety)

      #case 39
  elseif (unit == "flyingstag")
    return validateMod.flyingStagValidate(team, sourcex, sourcey, targetx, targety)

      #case 40
  elseif (unit == "dog")
    return dogValidate(team, sourcex, sourcey, targetx, targety)

      #case 41
  elseif (unit == "blindtiger")
    return validateMod.blindTigerValidate(team, sourcex, sourcey, targetx, targety)

      #case 42
  elseif (unit == "whitehorse")
    return validateMod.whiteHorseValidate(team, sourcex, sourcey, targetx, targety)

      #case 43
  elseif (unit == "whale")
    return validateMod.whaleValidate(team, sourcex, sourcey, targetx, targety)

      #case 44
  elseif (unit == "lance")
    return validateMod.lanceValidate(team, sourcex, sourcey, targetx, targety)

      #case 45
  elseif (unit == "reversechariot")
    return validateMod.reverseChariotValidate(team, sourcex, sourcey, targetx, targety)

  else
    return false #invalid unitType

end #tenjikuMoveValidate

#if lower rank can capture
function lowerRank(unit, targetUnit)

  if unit == "vicegeneral"
    if targetUnit == "king" || targetUnit == "prince" || targetUnit == "greatgeneral" || targetUnit == "vicegeneral"
      return false #cannot jump
    else
      return true #jump
    end

  elseif unit == "greatgeneral"
    if targetUnit == "king" || targetUnit == "prince" || targetUnit == "greatgeneral"
      return false
    else
      return true
    end

  elseif unit == "bishopgeneral" || unit == "rookgeneral"
    if targetUnit == "king" || targetUnit == "prince" || targetUnit == "greatgeneral" || targetUnit == "vicegeneral" || targetUnit == "rookgeneral"
      return false
    else
      return true
    end
  end

  return false
end #lowerRank

#checks if the captured piece can be captured by jumping
function jumpCapture(unit , targetUnit)

  if unit == "vicegeneral" || unit == "greatgeneral" || unit == "bishopgeneral" || unit == "rookgeneral"
    if targetUnit == "king" || targetUnit == "prince"
      return false #cannot jumpCapture
    else
      return true
    end
  end

  return false
end #jumpCapture

#moveUpValidate <=== Return true if unit can move veritcally upwards to target ===>
function rangeUpValidate(sourcex, sourcey, targetx, targety, unit)
  if (sourcey != targety)
    return false
  end

  unitCheck = abs(sourcex - targetx) - 1
  x = sourcex - 1
  jumpFlag = false

  for unit in 1:unitCheck
    if !((x,targety) in keys(board))
      x = x - 1
    elseif lowerRank(unit, board[(x,targety)][1]) == true #tagetUnit is lower rank
      jumpFlag = true
      x = x - 1
    else
      return false
    end
  end

  if jumpFlag == true
    if (jumpCapture(unit, board[targetx,targety][1]) == false) #jump capturing something that is higher rank
      return false
    end
  end

  return true
end #moveUpValidate

#moveDownValidate <=== Return true if unit can move veritcally downwards to target ===>
function rangeDownValidate(sourcex, sourcey, targetx, targety, unit)
  if (sourcey != targety)
    return false
  end

  unitCheck = abs(sourcex - targetx) - 1
  x = sourcex + 1
  jumpFlag = false

  for unit in 1:unitCheck
    if !((x,targety) in keys(board))
      x = x + 1
    elseif lowerRank(unit, board[(x,targety)][1]) == true
      jumpFlag = true
      x = x + 1
    else
      return false
    end
  end

  if jumpFlag == true
    if (jumpCapture(unit, board[targetx,targety][1]) == false) #jump capturing something that is higher rank
      return false
    end
  end

  return true
end #moveDownValidate

#moveLeftValidate <=== Return true if unit can move horizontally left to target ===>
function rangeLeftValidate(sourcex, sourcey, targetx, targety, unit)
  if (sourcex != targetx)
    return false
  end

  unitCheck = abs(sourcey - targety) - 1
  y = sourcey - 1
  jumpFlag = false;

  for unit in 1:unitCheck
    if !((targetx,y) in keys(board))
      y = y - 1
    elseif lowerRank(unit, board[(sourcex,y)][1]) == true
      jumpFlag = true;
      y = y - 1
    else
      return false
    end
  end

  if jumpFlag == true
    if (jumpCapture(unit, board[targetx,targety][1]) == false) #jump capturing something that is higher rank
      return false
    end
  end

  return true
end #moveLeftValidate

#moveRightValidate <=== Return true if unit can move horizontally Right to target ===>
function rangeRightValidate(sourcex, sourcey, targetx, targety, unit)
  if (sourcex != targetx)
    return false
  end

  unitCheck = abs(sourcey - targety) - 1
  y = sourcey + 1
  jumpFlag = false

  for unit in 1:unitCheck
    if !((targetx,y) in keys(board))
      y = y + 1
    elseif lowerRank(unit, board[(sourcex,y)][1]) == true
      jumpFlag = true;
      y = y + 1
    else
      return false
    end
  end

  if jumpFlag == true
    if (jumpCapture(unit, board[targetx,targety][1]) == false) #jump capturing something that is higher rank
      return false
    end
  end

  return true
end #moveLeftValidate

#diagonalUpLeft <=== Return true if unit can move diagonally upleft to target ===>
function rangeUpLeftValidate(sourcex, sourcey, targetx, targety, unit)
  if (sourcex - targetx) == (sourcey - targety)
    if (sourcex > targetx) #moving diagonal up left
      unitCheck == abs(sourcex - targetx) - 1
      x = sourcex - 1
      y = sourcey - 1
      jumpFlag = false

      for unit in 1:unitCheck
        if !((x,y) in keys(board))
          x = x - 1
          y = y - 1
        elseif lowerRank(unit, board[(x,y)][1]) == true
          jumpFlag = true
          x = x - 1
          y = y - 1
        else
          return false
        end
      end

      if jumpFlag == true
        if (jumpCapture(unit, board[targetx,targety][1]) == false) #jump capturing something that is higher rank
          return false
        end
      end

      return true
    end
  end

  return false
end #diagonalUpLeftValidate

#digonalUpRight <=== Return true if unit can move diagonally upleft to target ===>
function rangeUpRightValidate(sourcex, sourcey, targetx, targety, unit)
  if (sourcex - targetx) == (targety - sourcey)
    if (sourcex > targetx) #moving diagonal up right
      unitCheck == abs(sourcex - targetx) - 1
      x = sourcex - 1
      y = sourcey + 1
      jumpFlag = false

      for unit in 1:unitCheck
        if !((x,y) in keys(board))
          x = x - 1
          y = y + 1
        elseif lowerRank(unit, board[(x,y)][1]) == true
          jumpFlag = true
          x = x - 1
          y = y + 1
        else
          return false
        end
      end

      if jumpFlag == true
        if (jumpCapture(unit, board[targetx,targety][1]) == false) #jump capturing something that is higher rank
          return false
        end
      end

      return true
    end
  end

  return false
end #diagonalUpRightValidate

#diagonalDownLeft <=== Return true if unit can move diagonally downleft to target ===>
function rangeDownLeftValidate(sourcex, sourcey, targetx, targety, unit)
  if (sourcex - targetx) == (targety - sourcey)
    if (sourcex < targetx) #moving diagonal down left
      unitCheck == abs(sourcex - targetx) - 1
      x = sourcex + 1
      y = sourcey - 1
      jumpFlag = false

      for unit in 1:unitCheck
        if !((x,y) in keys(board))
          x = x + 1
          y = y - 1
        elseif lowerRank(unit, board[(x,y)][1]) == true
          jumpFlag = true;
          x = x + 1
          y = y - 1
        else
          return false
        end
      end

      if jumpFlag == true
        if (jumpCapture(unit, board[targetx,targety][1]) == false) #jump capturing something that is higher rank
          return false
        end
      end

      return true
    end
  end

  return false
end #diagonalDownLeftValidate

#diagonalDownRight
function rangeDownRightValidate(sourcex, sourcey, targetx, targety, unit)
  if (sourcex - targetx) == (sourcey - targety)
    if (sourcex < targetx) #moving diagonal down left
      unitCheck == abs(sourcex - targetx) - 1
      x = sourcex + 1
      y = sourcey + 1
      jumpFlag = false

      for unit in 1:unitCheck
        if !((x,y) in keys(board))
          x = x + 1
          y = y + 1
        elseif lowerRank(unit, board[(x,y)][1]) == true
          jumpFlag = true
          x = x + 1
          y = y + 1
        else
          return false
        end
      end

      if jumpFlag == true
        if (jumpCapture(unit, board[targetx,targety][1]) == false) #jump capturing something that is higher rank
          return false
        end
      end

  return false
end #diagonalDownRightValidate


#case 5
function viceGeneralValidate(team, sourcex, sourcey, targetx, targety, targetx2, targety2, targetx3, targety3)

  target2 = true
  target3 = true
  if (targetx2 == -1 || targety2 == -1)
    target2 == false;
  if (targetx3 == -1 || targety3 == -1)
    target3 == false;

  #area move
  if (abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0)
    if (abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0)
      if ! ((targetx,targety) in keys(board)) # Empty
        if (abs(targetx2 - targetx) == 1) || (abs(targetx2 - targetx) == 0)
          if (abs(targety2 - targety) == 1) || (abs(targety2 - targety) == 0)
            if ! ((targetx2,targety2) in keys(board)) # Empty
              if (abs(targetx2 - targetx3) == 1) || (abs(targetx2 - targetx3) == 0)
                if (abs(targety2 - targety3) == 1) || (abs(targety2 - targety3) == 0)
                  return true;
                end
              end
            else
              if (target3 == false)
                return true;
              end
            end
          end
        end
      else
        if (target2 == false) && (target3 == false)
          return true;
      end
    end
  end

  #Range Jump
  if (target2 == false && target3 == false)
    if (sourcex < targetx) #move down
      if (sourcey < targety) #move down Right
        if (rangeDownRightValidate(sourcex, sourcey, targetx, targety, "vicegeneral") == true)
          return true
        end
      else #move down left
        if (rangeDownLeftValidate(sourcex, sourcey, targetx, targety, "vicegeneral") == true)
          return true
        end
      end
    else #move up
      if (sourcey < targety) #move up Right
        if (rangeUpRightValidate(sourcex, sourcey, targetx, targety, "vicegeneral") == true)
          return true
        end
      else #move down left
        if (rangeUpLeftValidate(sourcex, sourcey, targetx, targety, "vicegeneral") == true)
          return true
        end
      end
    end
  end

  return false
end #viceGeneralValidate

#case 6
function greatGeneralValidate(team, sourcex, sourcey, targetx, targety)
  #moves like bishop
  if (abs(sourcex - targetx) == abs(sourcey - targety)) #moves diagonally
    if (sourcex < targetx) #downwards
      if (sourcey < targety) #diagonalDownRight
        if (rangeDownRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #diagonalDownLeft
        if (rangeDownLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    else #upwards
      if (sourcey < targety) #diagonalUpRightValidate
        if (rangeUpRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #diagonalUpLeft
        if (rangeUpLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end
  end

  #moves like rook
  if (sourcex == targetx) && (sourcey != targety) #moving horizontally
    if (sourcey > targety) #horizontal left
      if (rangeLeftValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end


    else #horizontal right
      if (rangeRightValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    end

  elseif (sourcey == targety) && (sourcex != targetx) #moving vertically
    if (sourcex > targetx) #vertical up
      if (rangeUpValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    else #vertical down
      if (rangeDownValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    end
  end

  return false
end #greatGeneralValidate

#case 7
function bishopGeneralValidate(team, sourcex, sourcey, targetx, targety)
  #moves like bishop
  if (abs(sourcex - targetx) == abs(sourcey - targety)) #moves diagonally
    if (sourcex < targetx) #downwards
      if (sourcey < targety) #diagonalDownRight
        if (rangeDownRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #diagonalDownLeft
        if (rangeDownLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    else #upwards
      if (sourcey < targety) #diagonalUpRightValidate
        if (rangeUpRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      else #diagonalUpLeft
        if (rangeUpLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end
  end

  return false
end #bishopGeneralValidate

#case 8
function rookGeneralValidate(team, sourcex, sourcey, targetx, targety)
  #moves like rook
  if (sourcex == targetx) && (sourcey != targety) #moving horizontally
    if (sourcey > targety) #horizontal left
      if (rangeLeftValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    else #horizontal right
      if (rangeRightValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    end

  elseif (sourcey == targety) && (sourcex != targetx) #moving vertically
    if (sourcex > targetx) #vertical up
      if (rangeUpValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    else #vertical down
      if (rangeDownValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    end
  end

  return false
end #rookGeneralValidate

#case 18
function fireDemonValidate(team, sourcex, sourcey, targetx, targety, targetx2, targety2, targetx3, targety3)
  #range
  if (validateMod.moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
    return true
  end

  if (validateMod.moveRightValidate(sourcex,sourcey,targetx,targety) == true)
    return true
  end

  if (validateMod.moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
    return true
  end

  #Area move
  flag2 = false
  flag3 = false

  if (targetx2 != -1 || targety2 != -1)
    flag2 = true
  end

  if (targetx3 != -1 || targety3 != -1)
    flag3 = true
  end

  if (abs(sourcex - targetx) == 1 || abs(sourcex - targetx) == 0) && ((abs(sourcey - targety) == 1) || abs(sourcey - targety == 0))
    if flag2 = true
      if ((targetx,targety) in keys(board)) #captured a piece
        return false
      else
        if (abs(targetx2 - targetx) == 1 || abs(targetx2 - targetx) == 0) && ((abs(targety2 - targety) == 1) || abs(targety2 - targety == 0))
          if flag3 = true
            if ((targetx2,targety2) in keys(board))
                return false
            else
              if (abs(targetx2 - targetx3) == 1 || abs(targetx2 - targetx3) == 0) && ((abs(targety2 - targety3) == 1) || abs(targety2 - targety3 == 0))
                return true
              end
            end
          else
            return true
          end
        end
      end
    else #flag2 = false
      return true
    end
  end
end #fireDemonValidate

#case 19
function heavenlyTetrarchValidate(team, sourcex, sourcey, targetx, targety, targetx2, targety2)

  flag2 = false
  if (targetx2 != -1 || targety2 != -1)
    flag2 = true
  end

  #igui
  if flag2 == true
    if (abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0)
      if (abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0)
        if (sourcex == targetx2) && (sourcey == targety2)
          return true
        end
      end
    end
  end

  #range
  if flag2 == false
    if (abs(sourcex - targetx) == 1) || (abs(sourcex - targetx) == 0)
      if (abs(sourcey - targety) == 1) || (abs(sourcey - targety) == 0)
        return false
      end

    #side ways
    else if (sourcex == targetx)
      if (abs(sourcey  - targety) == 3)
        if sourcey < targety #move right
          if (validateMod.moveRightValidate(sourcex,sourcey+1,targetx,targety) == true)
            return true
          end
        else #move left
          if (validateMod.moveLeftValidate(sourcex,sourcey-1,targetx,targety) == true)
            return true
          end
        end
      end

    #diagonalUpLeft
    else if abs(sourcex - targetx) == abs(sourcey - targety)
      if sourcex < targetx #move down
        if sourcey < targety #move right
          if (validateMod.diagonalDownRightValidate(sourcex+1,sourcey+1,targetx,targety) == true)
            return true
          end
        else #move left
          if (validateMod.diagonalDownLeftValidate(sourcex+1,sourcey-1,targetx,targety) == true)
            return true
          end
        end
      else #move up
        if sourcey < targety #move right
          if (validateMod.diagonalUpRightValidate(sourcex-1,sourcey+1,targetx,targety) == true)
            return true
          end
        else #move left
          if (validateMod.diagonalUpLeftValidate(sourcex-1,sourcey-1,targetx,targety) == true)
            return true
          end
        end
      end
    end
  end

  return false
end #heavenlyTetrarchValidate

#case 20
function waterBuffaloValidate(team, sourcex, sourcey, targetx, targety)

  #check if moves like bishop
  if (validateMod.moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
    return true
  end

  #moves sideways
  if (sourcex == targetx)
    if (sourcey < targety) #move right
      if (validateMod.moveRightValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    else #move left
      if (validateMod.moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    end
  end

  #two up or down
  if (sourcey == targety)
    if (abs(sourcex - targetx) == 2)
      return true
    end
  end

  return false
end #waterBuffaloValidate

#case 21
function chariotSoldierValidate(team, sourcex, sourcey, targetx, targety)

  #moves like bishop
  if (validateMod.moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
    return true
  end

  #moves vertically
  if (sourcey == targety)
    if (sourcex < targetx) #move down
      if (validateMod.moveDownValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    else #move up
      if (validateMod.moveUpValidate(sourcex,sourcey,targetx,targety) == true)
        return true
      end
    end
  end

  #move two left or right
  if (sourcex == targetx)
    if (abs(sourcey - targety) == 2)
      return true
    end
  end

  return false
end #chariotSoldierValidate

#case 22
function sideSoldierValidate(team, sourcex, sourcey, targetx, targety)
  if (team == 'b')
    if (sourcey == targety)
      if (abs(sourcex - targetx) == 1) || (sourcex - targetx == 2)
        return true
    else #move left or right
      if (sourcey < targety) #move right
        if (validateMod.moveRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
      else #move left
        if (validateMod.moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
      end
    end
  elseif (team == 'w')
    if (sourcey == targety)
      if (abs(sourcex - targetx) == 1) || (sourcex - targetx == -2)
        return true
    else #move left or right
      if (sourcey < targety) #move right
        if (validateMod.moveRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
      else #move left
        if (validateMod.moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
      end
    end
  end

  return false
end #sideSoldierValidate

#case 23
function verticalSoldierValidate(team, sourcex, sourcey, targetx, targety)

  #sideways two
  if (sourcex == targetx)
    if (abs(sourcey - targety) == 2)
      return true
    end
  end

  if (team == 'b')
    #move forward
    if (sourcey == targety)
      if (sourcex < targetx) #move down
        if ((targetx - sourcex) == 1)
          return true
        end
      else #move up
        if (validateMod.moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end

  elseif (team == 'w')
    #move forward
    if (sourcey == targety)
      if (sourcex > targetx)
        if ((targetx - sourcex) == 1)
          return true
        end
      else
        if (validateMod.moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end
  end

  return false
end #verticalSoldierValidate

#case 25
function ironGeneralValidate(team, sourcex, sourcey, targetx, targety)
  if (team == 'b')
    if (sourcex - targetx == 1)
      if (abs(sourcey - targety) == 1) || (sourcey == targety)
        return true
      end
    end
  elseif (team == 'w')
    if (sourcex - targetx == -1)
      if (abs(sourcey - targety) == 1) || (sourcey == targety)
        return true
      end
    end
  end

  return false
end #ironGeneralValidate

#case 26
function freeEagleValidate(team, sourcex, sourcey, targetx, targety, targetx2, targety2)

  #Double move
  if (targetx2 != -1 || targety2 != -1)
    if (abs(sourcex - targetx) == 1 && abs(sourcey - targety) == 1 && (!((targetx,targety) in keys(board))))
      if (abs(targetx - targetx2) == 1 && abs(targety - targety2) == 1)
        return true
      end
    end

  #move diagonal
  else if (validateMod.moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
    return true

  #move orthogonal
  else if (validateMod.moveOrthogonalValidate(sourcex,sourcey,targetx,targety) == true)
    return true
  end

  return false
end #freeEagleValidate

#case 27
function lionHawkValidate(team, sourcex, sourcey, targetx, targety, targetx2, targety2)

  #lion move
  flag2 = false
  if (targetx2 == -1 || targety2 == -1)
    flag2 = true
  end

  if flag2 == true
    if (abs(sourcex - targetx) == 1 || abs(sourcex - targetx) == 0) && ((abs(sourcey - targety) == 1) || (abs(sourcey2 - targety) == 0))
      if (abs(targetx2 - targetx) == 1 || abs(targetx2 - targetx) == 0) && ((abs(targety2 - targety) == 1) || (abs(targety2 - targety2) == 0))
        return true
      end
    end

  #move diagonal
  else if (validateMod.moveDiagonalValidate(sourcex,sourcey,targetx,targety) == true)
    return true
  end

  return false
end #lionHawkValidate

#case 38
function multiGeneralValidate(team, sourcex, sourcey, targetx, targety)
  if (team =='b')
    #move up
    if (sourcey == targety)
      if (sourcex > targetx) #move up
        if (validateMod.moveUpValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end

    #diagonal down left or right
    if (abs(sourcex - targetx) == abs(sourcey - targety)) #moving diagonally
      if (targetx > sourcex) #move down
        if (targety < sourcey) #move left
          if (validateMod.diagonalDownLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #move right
          if (validateMod.diagonalDownRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      end
    end

  elseif (team =='w')
    #move up
    if (sourcey == targety)
      if (sourcex < targetx) #move down
        if (validateMod.moveDownValidate(sourcex,sourcey,targetx,targety) == true)
          return true
        end
      end
    end

    #diagonal down left or right
    if (abs(sourcex - targetx) == abs(sourcey - targety)) #moving diagonally
      if (targetx < sourcex) #move up
        if (targety > sourcey) #move right
          if (validateMod.diagonalUpRightValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        else #move right
          if (validateMod.diagonalUpLeftValidate(sourcex,sourcey,targetx,targety) == true)
            return true
          end
        end
      end
    end

  end

  return false
end #multiGeneralValidate

#40
function dogValidate(team, sourcex, sourcey, targetx, targety)
  if (team == 'b')
    if (sourcex - targetx == 1) && (sourcey == targety)
      return true
    end
    if (sourcex - targetx == -1) && (abs(sourcey - targety) == 1)
      return true
    end
  elseif (team == 'w')
    if (sourcex - targetx == -1) && (sourcey == targety)
      return true
    end
    if (sourcex - targetx == 1) && (abs(sourcey - targety) == 1)
      return true
    end
  end

  return false
end #dogValidate


#implement functions
#case 18,19
#done case: 5,6,7,8,20,21,22,23,25,26,27,38,40
#Pre-existing functions
#case 1,2,3,4,9,10,11,12,13,14,15,16,17,24,28,29,30,31,32,33,34,35,36,37,39,41,42,43,44,45
