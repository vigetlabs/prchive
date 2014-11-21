RSVP  = require('rsvp')
fs    = require('fs')
_     = require('underscore')

module.exports = (data)->
  new RSVP.Promise (resolve)->

    images = ''
    urls   = ''

    _(data.prs).each (pr)->
      _(pr.urls).each (url)->
        images += "<img src='#{url}'>\n"
        urls   += "#{url}\n"

    fs.writeFile("#{data.dirname}/images.html", images)
    fs.writeFile("#{data.dirname}/urls.txt",    urls)

    resolve(data)
