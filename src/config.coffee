RSVP   = require('rsvp')
fs     = require('fs')
prompt = require('prompt')
_      = require('underscore')

module.exports = new RSVP.Promise (resolve)->
  data = {}

  if (fs.existsSync('.config.json'))
    data.credentials = JSON.parse(fs.readFileSync('.config.json'))
    resolve(data)
  else
    prompt.get require('./config_credentials'), (err, result)->
      data.credentials = result
      resolve(data)
