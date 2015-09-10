local Object = require("lib.tool.object")

local Cockpit = Object:new();

function Cockpit:new (obj)
  obj = Object.new( self, obj )

  return obj
end

function Cockpit:create (avatar)
  local obj = self:new()
  obj.__index = function (t, k)
    -- For multiple acting
    for i, v in ipairs(avatar.robots) do
      local foundValue = v[k]

      if(foundValue) then
        t[k] = foundValue
        return foundValue
      end
    end

    -- Not found
    return nil
  end

  return obj
end

return Cockpit
