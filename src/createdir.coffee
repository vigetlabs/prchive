RSVP   = require('rsvp')
fs     = require('fs')
moment = require('moment')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    reponame  = data.credentials.repo.split('/')[1]
    timestamp = moment().format 'YYYY-MM-DD-HHmmss'
    data.dirname = "#{reponame}-media-archive--#{timestamp}"

    fs.mkdir data.dirname, ->
      console.log "\n  Created directory: #{data.dirname}".green
      resolve(data)
