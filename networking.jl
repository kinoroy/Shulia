function getAt(arr, index,backup)
  res=0
  try
    res = arr[index]
  catch err
    res = backup
  end
  return res
end

server = listen(8080)
i=0
global settingsSet = false
#player2 = accept(server)
while i<=2
  player = accept(server)
  global settingsSet
  @async begin
  i+=1
    gameType = ""
    legality = -1
    timelimit= -1
    limitadd = -1

    try
      wincode = -1
      sL=""
      line = readline(player)
      println("i start here")
      while wincode!=0 && !settingsSet
        sL = split(line,r":",keep=false)
        wincode = parse(chomp(sL[1]))
      end
      global settingsSet = true
      (gameType,legality,timelimit,limitadd) = (getAt(sL,2,'S'),getAt(sL,3,1),getAt(sL,4,-1),getAt(sL,5,-1))
      write(player,"$gameType, $legality,$timelimit,$limitadd")
    catch err
      print("connection ended with error $err")
    end

    #write(player,"$gameType, $legality,$timelimit,$limitadd")
  end

end
