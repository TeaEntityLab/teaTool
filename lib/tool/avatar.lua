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
-- @param isPilotExcluded if true, there's no pilot in robots
-- @return the avatar
function Avatar:create (pilot, isPilotExcluded)
  local obj = self:new()
  obj.pilot = pilot
  if not(isPilotExcluded) then
    obj:addRobot(pilot)
  end
  return obj
end

function Avatar:getCockpit ()
  return self.cockpit
end

function Avatar:getAct (tool)
  self.tool = tool
  return function (...)
    return self:act(...)
  end
end

--- Act the specific tool for the pilot.
--
-- @param ...
-- @return the result of acting
function Avatar:act (...)
  local iter, t, state = pairs(...)
  local k, v = iter(t, state)
  assert(k ~= nil and type(v) == "table")
  return self.tool[k](self.pilot, unpack(v))
end

return Avatar
