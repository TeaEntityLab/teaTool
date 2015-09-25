local Object = require("lib.tool.object")

local Cockpit = Object:new();

function Cockpit:new (obj)
  obj = Object.new( self, obj )

  return obj
end

function Cockpit:create (avatar)
  local indexDef = {}
  indexDef.__index = function (t, k)
    local foundValue

    -- For multiple acting
    for i, v in ipairs(avatar.robots) do
      foundValue = v[k]

      if(foundValue) then
        -- Don't save it because it's not inheritance
        -- rawset(t, k, foundValue)
        return foundValue
      end
    end

    -- TODO Get Cockpit own properties.
    -- return self[k]
  end
  indexDef.__newindex = function (t, k, v)
    rawset(avatar.pilot, k, v)
  end

  local obj = {}
  setmetatable(obj, indexDef)
  return obj
end

return Cockpit
