fs = require 'fs'

request   = require 'request'
{Promise} = require 'es6-promise'

module.exports = class Gyazo

  constructor: (@access_token = null) ->

  upload: (image) ->
    new Promise (resolve, reject) =>
      if typeof image is 'string'
        image = fs.createReadStream image
      url = "https://upload.gyazo.com/api/upload"
      request.post
        url: url
        qs:
          access_token: @access_token
      , (err, res, body) ->
        return reject err if err
        return reject res if res.statusCode isnt 200
        resolve JSON.parse body
      .form().append "imagedata", image


  list: ->
    new Promise (resolve, reject) =>
      url = "https://api.gyazo.com/api/images"
      request.get
        url: url
        qs:
          access_token: @access_token
      , (err, res, body) ->
        return reject err if err
        return reject res if res.statusCode isnt 200
        resolve JSON.parse body
