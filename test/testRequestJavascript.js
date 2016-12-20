var fs = require('fs');

var SyncPromise = require('sync-promise');
var LuaVM = require('lua.vm.js');

require("../lib/tool/package-searcher-nodejs");

function loadLuaScripts() {
  var l = new LuaVM.Lua.State();
  fs.readFile( __dirname + '/../lib/tool/package-searcher-nodejs.lua', function (err, data) {
    if (err) {
      console.log(err.toString());
      throw err;
    }
    // console.log(data.toString());

    // l.execute('function require(filename) js.global:requireLua(filename)  end');
    // l.execute('require("a")');
    l.execute('package.path = package.path .. ";../?.lua;?.lua;../?/init.lua;?/init.lua;test/?.lua"');
    l.execute(data.toString());
    l.execute("require('testRequest')");

    // l.execute('h = io.open("testRequest", "w")');
    // l.execute('h:write(...)', data.toString());
    // l.execute('h:close');
    // l.execute(data.toString());
    // l.execute("print(1)");
    // l.execute("require('testRequest.lua')");
  });
}


loadLuaScripts();
