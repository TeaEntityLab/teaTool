local Tool = require("lib.tool.tool")
local Env = require("lib.tool.env")

local Request = Tool:new()

if Env:isLuaJIT() then
  local luajitrequest = require("luajit-request")
  Request._send = luajitrequest.send
-- elseif Env:isNodeJS() then
--   Request._send = function(...)
--     local request = js.global:requireNodeAsFunction("sync-request")
--     local ok, resultOrErr = pcall(request, js.global, "GET", ...)
--     if ok and resultOrErr ~= nil then
--       local res = resultOrErr
--       return {code=res.statusCode, body=res:getBody()}
--     else
--       return {code=404, body="Not Implemented"}
--     end
--   end
elseif Env:isJavascript() then
  local operation = function(url, ...)
    -- print("logging:"..url)
    local args = ...
    local request
    if Env:isNodeJS() then
      js.global.XMLHttpRequest = js.global:requireNode("xmlhttprequest").XMLHttpRequest;
    end
    request = js.new(js.global.XMLHttpRequest);
    -- local request = js.new(js.global:requireNodeAsFunction("xhr2"));
    -- print(type(request))
    -- request:open("GET", url)-- synchronous request
    request:open("GET", url, false)-- synchronous request

    if type(args) == "table" then
      if type(args.timeout) == "number" then request.timeout = math.floor(args.timeout/1000) end
    end

    request:send(nil);
    return {code=request.status, body=request.responseText}
  end

  Request._send = function(url, ...)

    local ok, resultOrErr = pcall(operation, url, ...)
    if ok and resultOrErr ~= nil then
      local res = resultOrErr
      return res
    else
      return {code=404, body="Not Implemented"}
    end
  end
else
  -- TODO
end

function Request:send(...)
  return self._send(...)
end

return Request
