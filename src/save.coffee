RSVP     = require('rsvp')
_        = require('underscore')
httpSync = require('http-sync')
fs       = require('fs')
url      = require('url')
filesize = require('filesize')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    console.log "\n  Saving files:".green
    _(data.prs).each (pr)->
      _(pr.urls).each (mediaUrl)->
        filename = mediaUrl.substring mediaUrl.lastIndexOf('/') + 1
        path   = "#{data.dirname}/#{filename}"

        req = httpSync.request
          protocol : url.parse(mediaUrl).protocol,
          host     : url.parse(mediaUrl).host,
          path     : url.parse(mediaUrl).pathname,

        fs.writeFileSync(path, req.end().body)

        console.log "    #{filename} (#{filesize fs.statSync('./' + path).size})".grey

    resolve(data)
