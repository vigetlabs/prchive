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
      _(pr.files).each (file)->
        path   = "#{data.dirname}/#{file.name}"

        req = httpSync.request
          protocol : url.parse(file.url).protocol,
          host     : url.parse(file.url).host,
          path     : url.parse(file.url).pathname,

        fs.writeFileSync(path, req.end().body)

        console.log "    #{file.name} (#{filesize fs.statSync('./' + path).size})".grey

    resolve(data)
