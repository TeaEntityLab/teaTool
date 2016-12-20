var fs = require('fs');

var SyncPromise = require('sync-promise');
var LuaVM = require('lua.vm.js');

require("../lib/tool/package-searcher-nodejs");

var l = new LuaVM.Lua.State();
var data = fs.readFileSync( __dirname + '/../lib/tool/package-searcher-nodejs.lua', 'utf8');
l.execute('package.path = package.path .. ";test/?.lua;"');
l.execute(data.toString());
l.execute("require('testRequest')");
