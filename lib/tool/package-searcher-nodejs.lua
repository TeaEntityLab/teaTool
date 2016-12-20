local function load_lua_over_fs(url)
  -- print(url)
  -- local ok, err = pcall(js.global.require("fs").readFileSync, url)
  -- print(type(js.global.require("fs")));
  -- print(type(js.global.fs));
  local ok, err = pcall(js.global.requireLua, url)
  print(tostring(ok))
  print(tostring("ok"))

	if not ok then
		return nil, tostring(err)
	end

	return load(ok, url)
end

table.insert(package.searchers, function (mod_name)
  local func, err = load_lua_over_fs(mod_name)
  if func == nil then return "\n    " .. err end
  return func
end)
