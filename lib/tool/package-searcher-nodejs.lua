local function requireLua(url)
  return js.global:requireLua(url, package.path);
end
local function load_lua_over_fs(url)
  -- print(url)
  -- local ok, err = pcall(js.global.require("fs").readFileSync, url)
  -- print(type(js.global.require("fs")));
  -- print(type(js.global.fs));
  local ok, resultOrErr = pcall(requireLua, url)
  -- print(tostring(resultOrErr))
  -- print(tostring(ok))
  -- print(tostring("ok"))

	if not ok then
    print("ERROR:"..package.path);
		return nil, tostring(resultOrErr)
	end

	return load(resultOrErr, url)
end

table.insert(package.searchers, function (mod_name)
  local func, err = load_lua_over_fs(mod_name)
  if func == nil then return "\n    " .. err end
  return func
end)
