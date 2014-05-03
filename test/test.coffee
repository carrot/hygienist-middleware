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

  it 'should serve foo.html when /foo is requested', (done) ->
    chai.request(@app).get('/foo').res (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>foo</p>\n")
      done()

  it 'should serve foo.html when /foo/ is requested', (done) ->
    chai.request(@app).get('/foo/').res (res) ->
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

describe 'extensions', ->

  before ->
    @app = connect().use(hygienist(path.join(base_path, 'exts'), {clean: ['*.html', '*.json']}))

  it 'should serve index.html when /index is requested', (done) ->
    chai.request(@app).get('/index').res (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>hello world!</p>\n")
      done()

  it 'should redirect to /index when /index.html is requested', (done) ->
    chai.request(@app).get('/index.html').res (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>hello world!</p>\n")
      done()

  it 'should serve foo.json when /foo is requested', (done) ->
    chai.request(@app).get('/foo').res (res) ->
      res.should.have.status(200)
      res.should.be.json
      res.text.should.equal('{"foo": "bar"}\n')
      done()

  it 'should redirect to /foo when /foo.json is requested', (done) ->
    chai.request(@app).get('/foo.json').res (res) ->
      res.should.have.status(200)
      res.should.be.json
      res.text.should.equal('{"foo": "bar"}\n')
      done()

  it 'should serve not-matched.js when /not-matched.js is requested', (done) ->
    chai.request(@app).get('/not-matched.js').res (res) ->
      res.should.have.status(200)
      res.should.be.javascript
      done()

  it 'should error when /not-matched is requested', (done) ->
    chai.request(@app).get('/not-matched').res (res) ->
      res.should.have.status(404)
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
