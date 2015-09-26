package.path = package.path .. ";../?.lua;?.lua;"
local Tool = require("lib.tool.tool")
local Avatar = require("lib.tool.avatar")

local abstractCar = Tool:new()
abstractCar.controlEngine = Tool.abstract
function abstractCar:run ()
  print("Run!\nPreparing engine....")
  self:controlEngine()
  print("Rock n Roll!")
end

-- Test
local result, err

-- Test the implemented abstract function
local BatmanCar = abstractCar:new()
function BatmanCar:controlEngine ()
  print("Engine: Batman wins")
end
local theBatmanCar = BatmanCar:new()
theBatmanCar:run()
print()

-- Test the not implemented abstract function
local HalfCar = abstractCar:new()
local theHalfCar = HalfCar:new()
result, err = pcall(theHalfCar.run, theHalfCar)
assert(err ~= nil)
print("The expected error occurs")
print()
