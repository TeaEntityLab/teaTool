package.path = package.path .. ";../?.lua;?.lua;"
local Tool = require("tool")

local Car = Tool:new()
function Car:run (speed, duration)
  print("Distance: " .. speed * duration)
  print("I'm " .. self.name)
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
  car{run={120, 60},stop={},apple={}}
end

mycar:run()
