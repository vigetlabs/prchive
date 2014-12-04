RSVP      = require('rsvp')
_         = require('underscore')
httpSync  = require('http-sync')
url       = require('url')
pluralize = require('pluralize')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    _(data.prs).each (pr) ->
      pr.urls = []

      # http://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149
      matches = pr.body.match /(https?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\b/g

      matches = _(matches).map (mediaUrl) =>
        clyMatch = mediaUrl.match /^http:\/\/cl\.ly/
        if clyMatch?
          # remove file from end of cl.ly link
          mediaUrl = mediaUrl.replace /[a-zA-Z]\.[a-z]*$/, ''

          req = httpSync.request
            protocol : url.parse(mediaUrl).protocol,
            host     : url.parse(mediaUrl).host,
            path     : url.parse(mediaUrl).pathname,
            headers  :
              Accept: 'application/json',
          return JSON.parse(req.end().body.toString()).remote_url

        mediaUrl

      if matches?
        pr.urls = pr.urls.concat matches

    urlCount = _(data.prs).reduce (value, pr) ->
      value + pr.urls.length
    , 0

    console.log "\n  #{urlCount} #{pluralize('URL', urlCount)} found:".green

    _(data.prs).each (pr) ->
      _(pr.urls).each (url) -> console.log "    #{url}".grey

    resolve(data)
