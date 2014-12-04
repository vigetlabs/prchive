RSVP  = require('rsvp')
_     = require('underscore')
http  = require('http')
https = require('https')
fs    = require('fs')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    console.log '...saving'
    _(data.prs).each (pr)->
      pr.filenames = []
      _(pr.urls).each (url)->
        filename = url.substring url.lastIndexOf('/') + 1
        pr.filenames.push filename
        file     = fs.createWriteStream "#{data.dirname}/#{filename}"
        protocol = url.match(/^http(s|)/)[0]
        library  = if protocol is 'http' then http else https

        request = library.get url, (response)-> response.pipe(file);

    resolve(data)
