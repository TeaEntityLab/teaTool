package.path = package.path .. ";../?.lua;?.lua;../?/init.lua;?/init.lua;"
package.path = package.path .. ";../luajit-request/?/init.lua;luajit-request/?.lua;"
local Request = require("lib.tool.request")



local response = Request:send("https://example.com")

print(response.code)
print(response.body)
