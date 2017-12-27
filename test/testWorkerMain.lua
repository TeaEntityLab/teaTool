package.path = package.path .. ";../?.lua;?.lua;../?/init.lua;?/init.lua;"
package.path = package.path .. ";../luajit-request/?/init.lua;luajit-request/?.lua;"
local Worker = require("lib.tool.worker")

print("logging")

local worker = Worker:fromFile("test/testWorker")


-- print(Worker:fromFile(""))
print("logging")

worker:sendMessage(3)
worker:sendMessage(3)
worker:sendMessage(3)

local message = nil
-- print("message" .. message == nil)
while message == nil do
  message = worker:getMessage()
end
print(message)
worker:terminate()
