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
returnArgs = [];
returnWithArgs = function (...args) {
  returnArgs = args.length > 0 ? args : [];
  return;
}

cwd = function () {
  return "./";
}
cwdScript = function () {
  return cwd();
}
newWorker = function (filename) {
  var libdir = cwdScript() + "/";
  var remoteData = {
    data : [],
  };
  var worker = new Worker(libdir+"worker-lua.js");
  worker.onmessage = function (ev) {
    console.log("Received");
    // console.log("Received:"+ev.data);
    remoteData.data.push(ev.data);
  };
  worker.postMessage(filename);

  return {
    "worker" : worker,
    "remoteData" : remoteData,
  };
}
terminateWorker = function (config) {
  console.log("terminating"+config);
  config.worker.terminate();
  console.log("terminated");
}
sendMessage = function (config, message) {
  console.log(config, message);
  config.worker.postMessage(message);
}
getMessage = function (config) {
  var data = config.remoteData.data;
  // console.log("GetMessage:"+data);
  return data.length > 0 ? data.shift() : undefined;
}
