var fs = require('fs');

var LuaVM = require('lua.vm.js');

var libdir = process.cwd()+"/lib/tool/";
require(process.cwd()+"/plugin-js/"+"/package-searcher-nodejs");

var l = new LuaVM.Lua.State();
var data = fs.readFileSync( libdir + 'package-searcher-nodejs.lua', 'utf8');
l.execute('package.path = package.path .. ";test/?.lua;"');
l.execute(data.toString());
l.execute("require('testRequest')");
