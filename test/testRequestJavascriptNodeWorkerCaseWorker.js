var fs = require('fs');

var LuaVM = require('lua.vm.js');

var libdir = process.cwd()+"/lib/tool/";
console.log(libdir);
require(libdir+"package-searcher-nodejs");

function runLua(){
  var l = new LuaVM.Lua.State();
  var data = fs.readFileSync(libdir+"package-searcher-nodejs.lua", 'utf8');
  l.execute('package.path = package.path .. ";test/?.lua;"');
  l.execute(data.toString());
  l.execute("require('testRequest')");
}

onmessage = function (ev) {
  try {
    runLua();
  } catch (e) {
    console.log(e);
  } finally {}
  console.log(1);
  postMessage(ev.data);
};
