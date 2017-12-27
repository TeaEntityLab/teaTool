
require(process.cwd()+"/plugin-js/"+"package-searcher-nodejs");

var vm = undefined;

postBack = function () {
  console.log("returnArgs: "+returnArgs);
  postMessage(returnArgs);
  resumeArgs = [];
  returnArgs = [];
  console.log("returnArgs DONE");
};

// console.log("init");
onmessage = function (ev) {
  if (vm == undefined) {
    vm = loadLua(ev.data);
    // console.log("Loaded"+ev.data);
  }

  try {
    resumeLua(vm, ev.data);
    postBack();
  } catch (e) {
    console.log(e);
    close();
  } finally {}
};
