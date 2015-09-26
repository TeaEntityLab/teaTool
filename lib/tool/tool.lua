local Object = require("lib.tool.object")
local Avatar = require("lib.tool.avatar")

local Tool = Object:new();

function Tool:new (obj)
  obj = Object.new( self, obj )

  return obj
end

--- Create a single method avatar of this tool
--
-- @param pilot
-- @return the single method avatar method to emulate this tool
-- @usage #Avatar:create(pilot):getAct(tool)
function Tool:avatar (pilot)
  return Avatar:create(pilot):getAct(self)
end

function Tool:abstract ()
  error("Not Implemented yet")
end

return Tool
