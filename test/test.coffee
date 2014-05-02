connect = require 'connect'

describe 'basic', ->

  it 'should be registered as middleware', ->
    (-> connect().use(hygienist())).should.not.throw()

  it 'should modify a request body', (done) ->
    app = connect().use(hygienist("middleware'd!"))

    chai.request(app).get('/').res (res) ->
      res.should.have.status(500)
      res.text.should.equal("middleware'd!")
      done()
