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
  return function (...)
    return obj:act(...)
  end
end

function Avatar:act (...)
  local iter, t, state = pairs(...)
  local k, v = iter(t, state)
  if k == nil or v == nil then return nil end
  return self.tool[k](self.pilot, unpack(v))
end

return Avatar
