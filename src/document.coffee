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
      _(pr.files).each (file)->
        if file.name.match /.mov$/
          linkedMedia += "<embed src='#{file.url}' width='800' height='450'></embed>\n"
        else
          linkedMedia += "<img src='#{file.url}'>\n"
        urls += "#{file.url}\n"

    _(data.prs).each (pr)->
      _(pr.files).each (file)->
        if file.name.match /.mov$/
          localMedia += "<embed src='../#{file.name}' width='800' height='450'></embed>\n"
        else
          localMedia += "<img src='../#{file.name}'>\n"

    fs.writeFile("#{data.docdirname}/linked-media.html", linkedMedia)
    fs.writeFile("#{data.docdirname}/local-media.html", localMedia)
    fs.writeFile("#{data.docdirname}/urls.txt",    urls)

    resolve(data)
