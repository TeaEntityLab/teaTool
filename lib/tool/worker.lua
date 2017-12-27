local Tool = require("lib.tool.tool")
local Env = require("lib.tool.env")

local Worker = Tool:new()

-- Call by host

function Worker:fromFile (path)
  -- print("l:"..path)

  obj = Tool.new( self, obj )
  if Env.isJavascript() then
    self.config = js.global:newWorker(path)
  end

  return obj
end

function Worker:terminate ()
  if Env.isJavascript() then
    js.global:terminateWorker(self.config)
  end
end

function Worker:getMessage ()
  return js.global:getMessage(self.config)
end

function Worker:sendMessage (message)
  js.global:sendMessage(self.config, message)
end

-- Call by the worker's self

function Worker.yield(...)
  if Env.isJavascript() then
    js.global:returnWithArgs(...)
  end

  coroutine.yield()

  if Env.isJavascript() then
    return js.global.resumeArgs
  end
end

function Worker.exit(...)
  print("logging")
  js.global:close()
end

return Worker
