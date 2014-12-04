RSVP  = require('rsvp')
fs    = require('fs')
_     = require('underscore')

module.exports = (data)->
  new RSVP.Promise (resolve)->

    linkedMedia = ''
    localMedia  = ''
    urls        = ''

    _(data.prs).each (pr)->
      _(pr.urls).each (url)->
        if url.match /.mov$/
          linkedMedia += "<embed src='#{url}' width='800' height='450'></embed>\n"
        else
          linkedMedia += "<img src='#{url}'>\n"
        urls   += "#{url}\n"

    _(data.prs).each (pr)->
      _(pr.filenames).each (filename)->
        if filename.match /.mov$/
          localMedia += "<embed src='#{filename}' width='800' height='450'></embed>\n"
        else
          localMedia += "<img src='#{filename}'>\n"

    fs.writeFile("#{data.dirname}/linked-media.html", linkedMedia)
    fs.writeFile("#{data.dirname}/local-media.html", localMedia)
    fs.writeFile("#{data.dirname}/urls.txt",    urls)

    resolve(data)
