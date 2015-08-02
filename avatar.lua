local Object = require("object")

local Avatar = Object:new();

function Avatar:new (obj)
  obj = Object.new( self, obj )
  obj.acts = {}
  
  return obj
end

function Avatar:create (tool, pilot)
  local obj = self:new()
  obj.tool = tool
  obj.pilot = pilot
  return function (...) obj:act(...) end
end

function Avatar:act (...)
  for k,v in pairs(...) do
    self.tool[k](self.pilot, unpack(v))
  end
end

return Avatar
