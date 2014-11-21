RSVP   = require('rsvp')
fs     = require('fs')
moment = require('moment')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    console.log '...creating dir'
    reponame  = data.credentials.repo.split('/')[1]
    timestamp = moment().format 'YYYY-MM-DD-HHmmss'
    data.dirname = "#{reponame} media archive - #{timestamp}"
    fs.mkdir data.dirname, ->
      resolve(data)
