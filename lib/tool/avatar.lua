local Object = require("lib.tool.object")

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
  assert(k ~= nil and type(v) == "table")
  return self.tool[k](self.pilot, unpack(v))
end

return Avatar
