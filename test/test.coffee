connect = require 'connect'

describe 'basic', ->

  before ->
    @app = connect().use(hygienist(path.join(base_path, 'basic')))

  it 'should wrap static-serve', (done) ->
    chai.request(@app).get('/').res (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>hello world!</p>\n")
      done()

  it 'should serve foo as foo.html', (done) ->
    chai.request(@app).get('/foo').res (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>foo</p>\n")
      done()

  it 'should redirect .html to clean url', (done) ->
    chai.request(@app).get('/foo.html').res (res) ->
      res.redirects[0].should.match(/foo$/)
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>foo</p>\n")
      done()

  it 'should correctly handle querystrings', (done) ->
    chai.request(@app).get('/foo.html?wow=wowowow').res (res) ->
      res.redirects[0].should.match(/\/foo\?wow=wowowow$/)
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>foo</p>\n")
      done()

  it 'should correctly handle nested directories', (done) ->
    chai.request(@app).get('/nested/wow').res (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>wow</p>\n")
      done()

  it 'should correctly handle directory indices', (done) ->
    chai.request(@app).get('/nested').res (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>nested</p>\n")
      done()
