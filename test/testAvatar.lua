package.path = package.path .. ";../?.lua;?.lua;"
local Tool = require("lib.tool.tool")
local Avatar = require("lib.tool.avatar")

local Car = Tool:new()
function Car:run (speed, duration)
  local distance = speed * duration
  print("Distance: " .. distance)
  print("I'm " .. self.name)
  return distance
end
function Car:stop ()
  print("Stop")
end
function Car:apple ()
  print("Apple")
end
function Car:test (num)
  print("test: " .. num)
end

local BatmanCar = Tool:new()
function BatmanCar:go ()
  print("I'm batman~")
end

local mycar = Tool:new()
mycar.name = "MyCar"
function mycar:run ()
  local car = Car:avatar(self)
  print(car{run={120, 60}})
  car{stop={}}
  pcall(car, {apple={}})
  local result, err
  result, err = pcall(car, {test={1234}})
  assert(result and err == nil)
  result, err = pcall(car, {test=1234})
  assert((not result) and err ~= nil)
  result, err = pcall(car, {testNotExisting={4321}})
  assert((not result) and err ~= nil)

  ;
end

mycar:run()
