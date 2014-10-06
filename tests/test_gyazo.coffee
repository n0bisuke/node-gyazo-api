fs   = require 'fs'
path = require 'path'
require path.resolve 'tests', 'test_helper'

assert  = require 'assert'
{Promise} = require 'es6-promise'

Gyazo = require path.resolve()


describe 'GYAZO_TOKEN', ->

  it 'should have ENV var "GYAZO_TOKEN"', ->
    assert.equal typeof process.env.GYAZO_TOKEN, 'string'


describe '"upload" method', ->

  gyazo = new Gyazo process.env.GYAZO_TOKEN

  it 'should upload image', ->

    @timeout 10000

    gyazo.upload "#{__dirname}/test.jpg"
    .then (res) ->
      new Promise (resolve, reject) ->
        assert.equal typeof(res.response), 'object'
        assert.equal typeof(res.data.image_id), 'string'
        assert.equal /^https?:\/\/.+/.test(res.data.permalink_url), true
        assert.equal /^https?:\/\/.+/.test(res.data.url), true
        resolve res

  it 'should upload image from stream', ->

    @timeout 10000

    gyazo.upload fs.createReadStream "#{__dirname}/test.jpg"
    .then (res) ->
      assert.equal typeof(res.response), 'object'
      assert.equal typeof(res.data.image_id), 'string'
      assert.equal /^https?:\/\/.+/.test(res.data.permalink_url), true
      assert.equal /^https?:\/\/.+/.test(res.data.url), true


describe '"list" method', ->

  gyazo = new Gyazo process.env.GYAZO_TOKEN

  it 'should return list of images', ->

    @timeout 3000

    gyazo.list
      page: 2
      per_page: 5
    .then (res) ->
      assert.equal typeof(res.response), 'object'
      assert.equal res.data instanceof Array, true
      assert.equal res.data.length, 5
      assert.equal typeof(res.data[0].image_id), 'string'
      assert.equal /^https?:\/\/.+/.test(res.data[0].permalink_url), true
      assert.equal /^https?:\/\/.+/.test(res.data[0].url), true
      assert.equal res.response.headers['x-current-page'], 2
      assert.equal res.response.headers['x-per-page'], 5
