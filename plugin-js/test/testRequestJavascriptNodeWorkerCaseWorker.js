
require(process.cwd()+"/plugin-js/"+"package-searcher-nodejs");

onmessage = function (ev) {
  try {
    var vm = loadLua("test/testRequest");
    resumeLua(vm);
  } catch (e) {
    console.log(e);
  } finally {}
  console.log(1);
  postMessage(ev.data);
};
