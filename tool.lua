local Object = require("object")
local Avatar = require("avatar")

local Tool = Object:new();

function Tool:new (obj)
  obj = Object.new( self, obj )
  
  return obj
end

function Tool:avatar (pilot)
  return Avatar:create(self, pilot)
end

return Tool
