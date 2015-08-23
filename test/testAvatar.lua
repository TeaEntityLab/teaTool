package.path = package.path .. ";../?.lua;?.lua;"
local Tool = require("tool")

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

local mycar = Tool:new()
mycar.name = "MyCar"
function mycar:run ()
  local car = Car:avatar(self)
  print(car{run={120, 60}})
  car{stop={}}
  car{apple={}}
  car{}
end

mycar:run()
