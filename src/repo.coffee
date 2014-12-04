RSVP = require('rsvp')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    data.repo = data.client.repo(data.credentials.repo)
    data.repo.info (error, repoData) ->
      if error? then console.log(error.message)

      data.repoData = repoData
      resolve(data)
