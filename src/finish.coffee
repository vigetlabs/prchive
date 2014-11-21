RSVP  = require('rsvp')
_     = require('underscore')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    count = _(data.prs).reduce (memo, pr) ->
      memo + pr.urls.length
    , 0

    console.log "Done! #{count} items saved in #{data.dirname}"

    resolve(data)
