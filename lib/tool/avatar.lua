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

--- Create a single method avatar of the pilot
--
-- @param pilot real object which pilots the robot(s)
-- @return the avatar
function Avatar:create (pilot)
  local obj = self:new()
  obj.pilot = pilot
  return obj
end

function Avatar:getAct ()
  return function (...)
    return self:act(...)
  end
end

--- Act the robot(s) for the pilot
--
-- @param ...
-- @return the result of acting
function Avatar:act (...)
  local iter, t, state = pairs(...)
  local k, v = iter(t, state)
  assert(k ~= nil and type(v) == "table")
  return self.cockpit[k](self.pilot, unpack(v))
end

return Avatar
