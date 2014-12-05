RSVP      = require('rsvp')
_         = require('underscore')
httpSync  = require('http-sync')
url       = require('url')
pluralize = require('pluralize')
$         = require('cheerio')

# http://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149
urlRegexp        = /(https?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\b/g
filenameRegexp   = /\/[^\/]*\.[a-z]*$/
cloupAppRegexp   = /^http:\/\/cl\.ly/

module.exports = (data)->
  new RSVP.Promise (resolve)->
    _(data.prs).each (pr) ->
      pr.files = []

      matches = pr.body.match urlRegexp

      matches = _(matches).map (mediaUrl) =>
        if mediaUrl.match cloupAppRegexp
          # remove filename from end of cl.ly link
          mediaUrl = mediaUrl.replace filenameRegexp , ''

          req = httpSync.request
            protocol : url.parse(mediaUrl).protocol,
            host     : url.parse(mediaUrl).host,
            path     : url.parse(mediaUrl).pathname,
            headers  :
              Accept: 'application/json'

          mediaUrl = JSON.parse(req.end().body.toString()).remote_url

          url:  mediaUrl
          name: pr.number + '__' + mediaUrl.match(filenameRegexp)[0].slice 1

        else if mediaUrl.match(filenameRegexp)?
          url:  mediaUrl
          name: pr.number + '__' + mediaUrl.match(filenameRegexp)[0].slice 1

      if matches?
        matches = _(matches).without(undefined)
        pr.files = pr.files.concat matches

    fileCount = _(data.prs).reduce (value, pr) ->
      value + pr.files.length
    , 0

    console.log "\n  #{fileCount} #{pluralize('URL', fileCount)} found:".green

    _(data.prs).each (pr) ->
      _(pr.files).each (file) -> console.log "    #{file.url}".grey

    resolve(data)
