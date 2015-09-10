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
-- @usage #Avatar:createSingleMethodAvatar
function Tool:avatar (pilot)
  return Avatar:createSingleMethodAvatar(self, pilot)
end

return Tool
