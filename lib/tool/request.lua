local Tool = require("lib.tool.tool")
local Env = require("lib.tool.env")

local Request = Tool:new()

if Env:isLuaJIT() then
  local luajitrequest = require("luajit-request")
  Request._send = luajitrequest.send
elseif Env:isNodeJS() then
  Request._send = function() return {code=404, body="Not Implemented"} end
else
  -- TODO
end

function Request:send(...)
  return self._send(...)
end

return Request
