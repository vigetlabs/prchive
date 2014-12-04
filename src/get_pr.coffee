RSVP = require('rsvp')

module.exports = (data, i)->
  new RSVP.Promise (resolve)->
    data.repo.prs
      page: i
      per_page: 100
      state: 'closed'
    , (error, prs)->

      if error? then console.log(error.message).red
      data.prs = data.prs.concat prs
      resolve()
