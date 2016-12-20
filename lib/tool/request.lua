local Tool = require("lib.tool.tool")
local Env = require("lib.tool.env")

local Request = Tool:new()

if Env.isLuaJIT() then
  local luajitrequest = require("luajit-request")
  Request._send = luajitrequest.send
else
  -- TODO
end

function Request:send(...)
  return self._send(...)
end

return Request
