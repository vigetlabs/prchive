// Generated by CoffeeScript 1.9.1
(function() {
  module.exports = {
    run: function() {
      return require('./config').then(require('./client')).then(require('./repo')).then(require('./prs')).then(require('./parse')).then(require('./createdir')).then(require('./save')).then(require('./document')).then(require('./finish'))["catch"](function(error) {
        return console.log(error.stack);
      });
    }
  };

}).call(this);
