LuaVM = require('lua.vm.js');

loadLua = function (filename, relativeBaseDir){
  relativeBaseDir = relativeBaseDir == undefined ? "" : relativeBaseDir;
  var libdir = "./"+relativeBaseDir+"/lib/tool/";
  var l = new LuaVM.Lua.State();
  // l.execute('package.path = package.path .. ";test/?.lua;"');
  l.execute('package.path = package.path .. ";?.lua;"');
  l.execute("require('"+libdir+"package-searcher-nodejs.lua')");
  l.execute("main = coroutine.create(function () \
           require('"+filename+"') \
         end)");

  return l;
}
resumeArgs = [];
resumeLua = function (l, ...args) {
  resumeArgs = args.length > 0 ? args : [];
  l.execute("coroutine.resume(main)");
  return;
}
