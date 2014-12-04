RSVP  = require('rsvp')
fs    = require('fs')
_     = require('underscore')

module.exports = (data)->
  new RSVP.Promise (resolve)->

    linkedMedia = ''
    localMedia  = ''
    urls        = ''

    data.docdirname = "#{data.dirname}/docs"

    fs.mkdirSync data.docdirname

    _(data.prs).each (pr)->
      _(pr.urls).each (mediaUrl)->
        if mediaUrl.match /.mov$/
          linkedMedia += "<embed src='#{mediaUrl}' width='800' height='450'></embed>\n"
        else
          linkedMedia += "<img src='#{mediaUrl}'>\n"
        urls += "#{mediaUrl}\n"

    _(data.prs).each (pr)->
      _(pr.urls).each (mediaUrl)->
        match = mediaUrl.match /([^/])+/g
        filename = match[match.length - 1]
        if filename.match /.mov$/
          localMedia += "<embed src='../#{filename}' width='800' height='450'></embed>\n"
        else
          localMedia += "<img src='../#{filename}'>\n"

    fs.writeFile("#{data.docdirname}/linked-media.html", linkedMedia)
    fs.writeFile("#{data.docdirname}/local-media.html", localMedia)
    fs.writeFile("#{data.docdirname}/urls.txt",    urls)

    resolve(data)
