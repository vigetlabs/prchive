RSVP = require('rsvp')
_    = require('underscore')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    console.log '...getting prs'
    data.repo.prs
      per_page : 100
      state    : 'all'
    , (error, prs)->
      if error? then console.log(error.message)

      data.prs = _(prs).map (pr) -> _(pr).pick 'body', 'title'
      resolve(data)
