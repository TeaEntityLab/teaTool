package.path = package.path .. ";../?.lua;?.lua;../?/init.lua;?/init.lua;"
package.path = package.path .. ";../luajit-request/?/init.lua;luajit-request/?.lua;"
print("require:before")
local Worker = require("lib.tool.worker")

print("yield:before")
Worker.yield("30")
print("yield")

Worker.exit(0)
