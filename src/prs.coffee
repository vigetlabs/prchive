RSVP      = require('rsvp')
_         = require('underscore')
pluralize = require('pluralize')
pad       = require('pad')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    data.repo.prs
      per_page : 100
      state    : 'all'
    , (error, prs)->
      if error? then console.log(error.message)

      data.prs = _(prs).map (pr) -> _(pr).pick 'body', 'title', 'number'

      console.log "  #{data.prs.length} #{pluralize('PR', data.prs.length)} found:".green
      _(data.prs).each (pr) -> console.log "    #{pr.title}".grey

      maxNumLength = _(data.prs).max((pr)-> pr.number.toString().length).number.toString().length

      _(data.prs).each (pr) -> pr.number = pad(maxNumLength, pr.number, 0)

      resolve(data)
