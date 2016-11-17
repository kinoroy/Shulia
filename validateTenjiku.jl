include("square.jl")
include("dparse.jl")
include("validate.jl") #for pre-existing functions types

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

#case 5
function viceGeneralValidate(team, sourcex, sourcey, targetx, targety, targetx2, target2, targetx3, targety3)
end #viceGeneralValidate

#case 6
function greatGeneralValidate(team, sourcex, sourcey, targetx, targety)
end #greatGeneralValidate

#case 7
function bishopGeneralValidate(team, sourcex, sourcey, targetx, targety)
end #bishopGeneralValidate

#case 8
function rookGeneralValidate(team, sourcex, sourcey, targetx, targety)
end #rookGeneralValidate

#case 18
function fireDemonValidate(team, sourcex, sourcey, targetx, targety, targetx2, targety2, targetx3, targety3)
end #fireDemonValidate

#case 19
function heavenlyTetrarchValidate(team, sourcex, sourcey, targetx, targety, targetx2, targety2)
end #heavenlyTetrarchValidate

#case 20
function waterBuffaloValidate(team, sourcex, sourcey, targetx, targety)
end #waterBuffaloValidate

#case 21
function chariotSoldierValidate(team, sourcex, sourcey, targetx, targety)
end #chariotSoldierValidate

#case 22
function sideSoldierValidate(team, sourcex, sourcey, targetx, targety)
  if (team == 'b')
    if (sourcey == targety)
      if (abs(sourcex - targetx) == 1) || (sourcex - targetx == 2)
        return true
    else #move left or right
      if (sourcey < targety) #move right
        if (moveRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
      else #move left
        if (moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
      end
    end
  elseif (team == 'w')
    if (sourcey == targety)
      if (abs(sourcex - targetx) == 1) || (sourcex - targetx == -2)
        return true
    else #move left or right
      if (sourcey < targety) #move right
        if (moveRightValidate(sourcex,sourcey,targetx,targety) == true)
          return true
      else #move left
        if (moveLeftValidate(sourcex,sourcey,targetx,targety) == true)
          return true
      end
    end
  end

  return false
end #sideSoldierValidate

#case 23
function verticalSoldierValidate(team, sourcex, sourcey, targetx, targety)
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
end #freeEagleValidate

#case 27
function lionHawkValidate(team, sourcex, sourcey, targetx, targety, targetx2, targety2)
end #lionHawkValidate

#case 38
function multiGeneralValidate(team, sourcex, sourcey, targetx, targety)
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
#case 5,6,7,8,18,19,20,21,22,23,25,26,27,38,40
#done case: 22,25,40
#Pre-existing functions
#case 1,2,3,4,9,10,11,12,13,14,15,16,17,24,28,29,30,31,32,33,34,35,36,37,39,41,42,43,44,45
