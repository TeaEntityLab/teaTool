local Tool = require("lib.tool.tool")
local luajitrequest = require("luajit-request")

local Request = Tool:new()

if Tool.isLuaJIT() then
  local luajitrequest = require("luajit-request")
  Request._send = luajitrequest.send
else
  -- TODO
end



function Request:send(...)
  return self._send(...)
end

return Request
