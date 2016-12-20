local Tool = require("lib.tool.tool")
local Env = require("lib.tool.env")

local Process = Tool:new()

if Env.isLuaJIT() then
  local ffi = require("ffi")

  ffi.cdef[[
  typedef struct lua_State lua_State;
  typedef double lua_Number;
  lua_State *luaL_newstate(void);
  void luaL_openlibs(lua_State *L);
  void lua_close(lua_State *L);
  int luaL_loadstring(lua_State *L, const char *s);
  int lua_pcall(lua_State *L, int nargs, int nresults, int errfunc);
  lua_Number lua_tonumber(lua_State *L, int idx);
  ]]

  local C = ffi.C

  local L = C.luaL_newstate()
  local s = "local x = 0; for i=1,100 do x=x+i end; return x"
  C.luaL_openlibs(L)
  assert(C.luaL_loadstring(L, s) == 0)
  assert(C.lua_pcall(L, 0, 1, 0) == 0)
  assert(C.lua_tonumber(L, -1) == 5050)
  C.lua_close(L)
end



return Process
