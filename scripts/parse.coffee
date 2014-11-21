RSVP = require('rsvp')
_    = require('underscore')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    console.log '...parsing'

    _(data.prs).each (pr) ->
      pr.urls = []
      matches = pr.body.match /\(http.*?\.[a-zA-Z]+\)/i
      if matches?
        urls = _(matches).map (match) -> match.slice(1, -1)
        pr.urls = pr.urls.concat urls

    resolve(data)
