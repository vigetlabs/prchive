RSVP     = require('rsvp')
_        = require('underscore')
httpsync = require('httpsync')

module.exports = (data)->
  new RSVP.Promise (resolve)->
    console.log '...parsing'

    _(data.prs).each (pr) ->
      pr.urls = []

      # http://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149
      matches = pr.body.match /(https?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\b/g

      matches = _(matches).map (url) =>
        match = url.match /^http:\/\/cl\.ly/
        if match?
          url = url.replace /[a-zA-Z]\.[a-z]*$/, ''
          console.log url
          req = httpsync.request
            url     : url,
            method  : 'GET',
            headers :
              Accept: 'application/json',
          JSON.parse(req.end().data.toString()).remote_url
        else
          url

      if matches?
        pr.urls = pr.urls.concat matches

    resolve(data)
