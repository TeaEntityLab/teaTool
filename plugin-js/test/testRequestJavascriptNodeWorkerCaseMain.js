var Worker = require("tiny-worker");
var worker = new Worker("./plugin-js/test/testRequestJavascriptNodeWorkerCaseWorker.js");

worker.onmessage = function (ev) {
    console.log(ev.data);
    console.log("Message");
    worker.terminate();
};

worker.postMessage("Hello World!");
