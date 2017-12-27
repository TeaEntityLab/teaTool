package.path = package.path .. ";../?.lua;?.lua;../?/init.lua;?/init.lua;"
package.path = package.path .. ";../luajit-request/?/init.lua;luajit-request/?.lua;"
local Request = require("lib.tool.request")



local response = Request:send("https://www.example.com", {timeout=3000})
local typeResponse = type(response)

if typeResponse == "table" then
  print(response.code)
  print(response.body)
else
  print(response)
end

print(js.global.resumeArgs)
