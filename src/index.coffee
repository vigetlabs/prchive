module.exports =
  run: ->
     require('./config')
      .then(require('./client'))
      .then(require('./repo'))
      .then(require('./prs'))
      .then(require('./parse'))
      .then(require('./createdir'))
      .then(require('./save'))
      .then(require('./document'))
      .then(require('./finish'))
      .catch (error)-> console.log error.stack
