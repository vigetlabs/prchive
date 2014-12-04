RSVP      = require('rsvp')
_         = require('underscore')
pluralize = require('pluralize')
pad       = require('pad')

module.exports = (data)->
  new RSVP.Promise (resolve)->

    data.prs = []
    prPromises = (require('./get_pr')(data, i) for i in [1..10])

    RSVP.all(prPromises).then ()->
      console.log "  #{data.prs.length} #{pluralize('PR', data.prs.length)} found:".green

      data.prs = _(data.prs).map (pr) -> _(pr).pick 'body', 'title', 'number'
      _(data.prs).each (pr) -> console.log "    #{pr.title}".grey

      maxNumLength = _(data.prs).max((pr)-> pr.number.toString().length).number.toString().length
      _(data.prs).each (pr) -> pr.number = pad(maxNumLength, pr.number.toString(), 0)

      resolve(data)
