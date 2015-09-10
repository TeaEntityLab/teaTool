local Object = require("lib.tool.object")
local Cockpit = require("lib.tool.cockpit")

local Avatar = Object:new();

function Avatar:new (obj)
  obj = Object.new( self, obj )

  obj.robots = {}
  obj.cockpit = Cockpit:create(obj)

  return obj
end

function Avatar:addRobot (robot)
  table.insert(self.robots, robot)
end

--- Create a single method avatar of the robot
--
-- @param singleMethodRobot the robot to be piloted
-- @param singleMethodPilot real object which pilots the robot
-- @return the method which emulates the single method avatar
function Avatar:createSingleMethodAvatar (singleMethodRobot, singleMethodPilot)
  local obj = self:new()
  obj.singleMethodRobot = singleMethodRobot
  obj.singleMethodPilot = singleMethodPilot
  return function (...)
    return obj:actSingleMethod(...)
  end
end

--- Act just a single method of the robot for the pilot
--
-- @param ...
-- @return the result of acting
function Avatar:actSingleMethod (...)
  local iter, t, state = pairs(...)
  local k, v = iter(t, state)
  assert(k ~= nil and type(v) == "table")
  return self.singleMethodRobot[k](self.singleMethodPilot, unpack(v))
end

return Avatar
