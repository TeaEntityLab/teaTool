var fs = require('fs');
var pathUtils = require('path');
requireNode = function(url){
  return require(url);
}
requireNodeAsFunction = function(url) {
  // console.log(Array.prototype.slice.call(arguments));

  return function() {
    var args = Array.prototype.slice.call(arguments);
    console.log(args);
    var mod = requireNode(url);
    try {
      return mod.apply(this, args);
    } catch (e) {
      console.log(e);
      return null;
    } finally {
    }
  };
}
requireLua = function (url, path) {
  path = path.replace(/[?]/g, url);
  // console.log(path);
  var result = "print('Require Failed:"+url+"')";
  var list = path.split(";");
  // console.log(list.length);
  list.forEach(
    function(item){
      var filename = item;
      var content;
      content = getContent(filename);
      if (content !== void 0) {
        result = content;
      }
      filename = filename.replace(/[.]lua/g, "")
      content = getContent(filename.replace(/[.]/g, "/")+".lua");
      if (content !== void 0) {
        result = content;
      }
    }
  );

  // result = fs.readFileSync(__dirname + "/" + filename, "utf8");
  return result;
}

function getContent(filename){
  var result = void 0;
  try {
    // var path = __dirname + "/" + filename;
    var path = process.cwd() + "/" + filename;
    // var path = pathUtils.dirname(fs.realpathSync(__filename)) + "/" + filename;
    // console.log(path);
    result = fs.readFileSync(path, "utf8");
  } catch (e) {
    // console.log(e);
  } finally {
    return result;
  }
}
