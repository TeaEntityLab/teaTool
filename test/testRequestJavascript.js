var fs = require('fs');

var LuaVM = require('lua.vm.js');

requireLua = function (filename) {
  console.log("Filename:"+filename);
  var buf = fs.readFileSync(__dirname + "/" + filename, "utf8");

}

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
    l.execute(data.toString());
    l.execute("require('./testRequest.lua')");

    // l.execute('h = io.open("testRequest", "w")');
    // l.execute('h:write(...)', data.toString());
    // l.execute('h:close');
    // l.execute(data.toString());
    l.execute("print(1)");
    // l.execute("require('testRequest.lua')");
  });
}


loadLuaScripts();
