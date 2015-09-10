local Object = require("lib.tool.object")

local Cockpit = Object:new();

function Cockpit:new (obj)
  obj = Object.new( self, obj )

  return obj
end

function Cockpit:create (avatar)
  local indexDef = self:new()
  indexDef.__index = function (t, k)
    -- For multiple acting
    for i, v in ipairs(avatar.robots) do
      local foundValue = v[k]

      if(foundValue) then
        t[k] = foundValue
        return foundValue
      end
    end

    -- TODO Get Cockpit own properties.
    -- return self[k]
  end

  local obj = {}
  setmetatable(obj, indexDef)
  return obj
end

return Cockpit
