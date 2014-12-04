RSVP	 = require('rsvp')
github = require('octonode')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    creds = data.credentials
    console.log '\n  Connecting client:'.green
    console.log "    username:     #{creds.username}".grey
    console.log "    password:     #{creds.password.replace(/./g, '*')}".grey
    console.log "    repo:         #{creds.repo}".grey

    data.client = github.client
      username: creds.username
      password: creds.password

    data.client.limit (error, left, max)->
      if error?
        console.log "  #{error.message}".red
      else
        console.log "\n  Requests until API limit: #{left}\n".yellow
        resolve(data)
