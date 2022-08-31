-- Kelp farming and farm building ( maybe upgrading farms too )

---------------------------------------
-- Basic functions for turtle control -
---------------------------------------
local function gf()  while not turtle.forward()   do end end
local function gb()  while not turtle.back()      do end end
local function gu()  while not turtle.up()        do end end
local function gd()  while not turtle.down()      do end end
local function tl()  while not turtle.turnLeft()  do end end
local function tr()  while not turtle.turnRight() do end end
local function df()  turtle.dig()       end
local function du()  turtle.digUp()     end
local function dd()  turtle.digDown()   end
local function pf()  turtle.place()     end
local function pu()  turtle.placeUp()   end
local function pd()  turtle.placeDown() end
local function sf()  turtle.suck()      end
local function su()  turtle.suckUp()    end
local function sd()  turtle.suckDown()  end
local function Df()  turtle.drop()      end
local function Du()  turtle.dropUp()    end
local function Dd()  turtle.dropDown()  end
local function ss(s) turtle.select(s)   end


local function askForInputText(textt)
  local at=""
  -- check prompting texts
  if textt==nil then textt="Enter text:" end
  -- ask for input
  write(textt)
  at=read() 
  return at
end


local function doSpin()
    for i=1,4,1 do tr() end
end


-- Program executed in farm mode 
if arg[1] == "farm" then

  local function f()
    -- fing code for fsize = 2 
    df()gf()tl()df()gf()tl()df()gf()
    tl()df()gf()
    gd()
    tl()
    df()gf()tl()df()gf()tl()df()gf()
    tl()df()gf()
    gu()
    tl()
  end

  local function check_ripe()
    local blockfront,data = turtle.inspect()
    if data.name == "minecraft:kelp" then
        return true
    else 
        return false
    end
  end

  if check_ripe() then
    print("kelp is ripe for the taking.")
    f()
  end

  -- fing loop 
  while true do 
    local fstate = check_ripe()
    print("f ripe ? : "..tostring(fstate))
    if fstate == true then
        f ()
    elseif fstate == false then 
        sleep(30)
    end
  end
elseif arg[1] == "build" then

  print("Kelp f : --------------------------")
  print("Mats needed [ slot : item ]")
  print("\t1 - 4  : ffloor / Sand")
  print("\t5 & 6  : Filled water buckets")
  print("\t7 - 15 : fwalling blocks")
  print("\t16     : Fuel")
  askForInputText("Press enter to continue ...")
  doSpin()

  local fsize = 0

  -- Start of execution 
  -- count mats and calculate size of f

  for i = 5,6 do --- Check if water sources are sufficient 
    local itemD = turtle.getItemDetail(i)
    if not (itemD==nil) then
      if itemD.name=="minecraft:water_bucket" then
        print(" + Water bucket detected good.")
      else 
        print(" - Put a Water bucket at slots 2 & 3")
      end
    else 
      print(" - Put a Water bucket at slots 2 & 3")
    end
  end --- Water sources are sufficient 
------------------------------------------------------------------------------
  local ffloorsize2 = 3 
  local ffloorsize4 = 35 
  local ffloorsize8 = 195 -- 390 yield 

  local total_ffloor = 0
  
  for i = 1,4 do --- Check if ffloor or sand is supplied  
    local itemD = turtle.getItemDetail(i)
    -- print(textutils.serialize(itemD))
    if not (itemD==nil) then
      if itemD.name=="minecraft:dirt" or itemD.name=="minecraft:sand" then
        print(" + Sand / ffloor exists good.")
        -- ckeck affordable size with mats available  
        local new_ffloor  = turtle.getItemCount(i)
        total_ffloor = total_ffloor + new_ffloor
        print("ffloor_level : "..tostring(total_ffloor))
      end
    else 
      print(" - Some materials missing from slots 1 - 4.")
      print(" - f size may be decreased .")
    end
  end --- ffloor counting finished 
  
  if total_ffloor > ffloorsize2 then
    fsize = 2 
    if total_ffloor > ffloorsize4 then
      fsize = 4 
      if total_ffloor > ffloorsize8 then 
        fsize = 8 -- whole chunks worth 
      end
    end 
  end
local fsizeffloor = fsize
------------------------------------------------------------------------------
------------------------------------------------------------------------------
  local fwallsize2 = 24 
  local fwallsize4 = 72 
  local fwallsize8 = 168 

  local total_fwall = 0
  
  for i = 7,15 do --- Check if item is supplied  
    local itemD = turtle.getItemDetail(i)
    -- print(textutils.serialize(itemD))
    if not (itemD==nil) then
        print(" + Item exists, good.")
        -- Check affordable size with mats available  
        local new_fwall  = turtle.getItemCount(i)
        total_fwall = total_fwall + new_fwall
        print("fwall_level : "..tostring(total_fwall))
    else 
      print(" - Some materials missing from slots 7 - 15.")
      print(" - f size may be decreased .")
    end
  end --- ffloor counting finished 
  
  if total_fwall > fwallsize2 then
    fsize = 2 
    if total_fwall > fwallsize4 then
      fsize = 4 
      if total_fwall > fwallsize8 then 
        fsize = 8 -- whole chunks worth 
      end
    end 
  end
  local fsizefwall = fsize
  print("f size allowed :")
  print("By ffloor : "..tostring(fsizeffloor))
  print("By fwalling blocks : "..tostring(fsizefwall))
  print("Final fwall size = "..tostring(fsize))
------------------------------------------------------------------------------
askForInputText("Press enter to continue ...")
print("fwalling a kelp f of size "..tostring(fsize))

end
