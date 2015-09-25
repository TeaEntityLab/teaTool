package.path = package.path .. ";../?.lua;?.lua;"
local Tool = require("lib.tool.tool")
local Avatar = require("lib.tool.avatar")

local Car = Tool:new()
Car.name = "Car"
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

local BatmanCar = Car:new()
BatmanCar.name = "BatmanCar"
function BatmanCar:go ()
  print("I'm batman~ My name is:" .. self.name)
end

local Lamborghini = Car:new()
Lamborghini.name = "Lamborghini"
function Lamborghini:gogogo ()
  print("I'm Lamborghini~ My name is:" .. self.name)
end

local mycar = Tool:new()
mycar.name = "MyCar"
function mycar:rename (name)
  self.name = name
end
function mycar:runrun ()
  -- Test Tool:avatar(pilot)
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
  self:rename("MyCar renamed")
  print(car{run={120, 60}})

  -- Test a manual created avatar's cockpit
  print()
  Lamborghini:new():gogogo()
  print()
  local superCarAvatar = Avatar:create(self)
  superCarAvatar:addRobot(BatmanCar)
  superCarAvatar:addRobot(Lamborghini)
  local superCockpit = superCarAvatar:getCockpit()
  superCockpit:rename("MyCar cockpit renamed")
  print(superCockpit:run(120, 60))
  superCockpit:stop()
  superCockpit:apple()
  superCockpit:test(1234)
  superCockpit:go()
  superCockpit:gogogo()

  -- Test nothing changed except mycar after acting
  -- by Avatar:getAct() & Avatar:getCockpit()
  assert(self.run == nil)
  assert(self.stop == nil)
  assert(self.apple == nil)
  assert(self.test == nil)
  assert(self.go == nil)
  assert(self.gogogo == nil)
  assert(Car.name == "Car")
  assert(BatmanCar.name == "BatmanCar")
  assert(Lamborghini.name == "Lamborghini")

  -- Test cockpit's __newindex
  local oldGo = superCockpit.go
  assert(oldGo == superCockpit.go)
  superCockpit.go = function () print("New Go! Name: " .. self.name) end
  assert(oldGo ~= superCockpit.go)
  assert(superCockpit.go == self.go)
  superCockpit:go()
  assert(self.idonthavethis == nil)
  superCockpit.idonthavethis = "it's not"
  assert(self.idonthavethis == "it's not")
end

mycar:runrun()
