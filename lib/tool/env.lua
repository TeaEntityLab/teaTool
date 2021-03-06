local Tool = require("lib.tool.tool")

local Env = Tool:new()

function Env:isLuaJIT()
  local value = type(jit) == 'table'
  return value, value and jit.version or nil
end

function Env:isJavascript()
  local value = type(js) == 'table'
  return value
end

function Env:isNodeJS()
  local value = self:isJavascript() and js.global.process ~= nil
  return value
end

return Env
