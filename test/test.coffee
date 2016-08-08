connect      = require 'connect'
serve_static = require 'serve-static'

describe 'basic', ->

  before ->
    _path = path.join(base_path, 'basic')
    @app = connect()
      .use(hygienist(_path))
      .use(serve_static(_path))

  it 'should pass files through to be served', ->
    chai.request(@app).get('/').then (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>hello world!</p>\n")

  it 'should serve foo.html when /foo is requested', ->
    chai.request(@app).get('/foo').then (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>foo</p>\n")

  it 'should not serve foo.html when /foo/ is requested', ->
    chai.request(@app).get('/foo/').then null, (res) ->
      res.should.have.status(404)

  it 'should redirect .html to clean url', ->
    chai.request(@app).get('/foo.html').then (res) ->
      res.redirects[0].should.match(/foo$/)
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>foo</p>\n")

  it 'should correctly handle querystrings', ->
    chai.request(@app).get('/foo.html?wow=wowowow').then (res) ->
      res.redirects[0].should.match(/\/foo\?wow=wowowow$/)
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>foo</p>\n")

  it 'should correctly handle nested directories', ->
    chai.request(@app).get('/nested/wow').then (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>wow</p>\n")

  it 'should correctly handle directory indices', ->
    chai.request(@app).get('/nested').then (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>nested</p>\n")

describe 'extensions', ->

  before ->
    _path = path.join(base_path, 'exts')
    @app = connect()
      .use(hygienist(_path, { extensions: ['*.html', '*.json'] }))
      .use(serve_static(_path))

  it 'should serve index.html when /index is requested', ->
    chai.request(@app).get('/index').then (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>hello world!</p>\n")

  it 'should redirect to /index when /index.html is requested', ->
    chai.request(@app).get('/index.html').then (res) ->
      res.redirects[0].should.match(/index$/)
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>hello world!</p>\n")

  it 'should serve foo.json when /foo is requested', ->
    chai.request(@app).get('/foo').then (res) ->
      res.should.have.status(200)
      res.should.be.json
      res.text.should.equal('{"foo": "bar"}\n')

  it 'should redirect to /foo when /foo.json is requested', ->
    chai.request(@app).get('/foo.json').then (res) ->
      res.redirects[0].should.match(/foo$/)
      res.should.have.status(200)
      res.should.be.json
      res.text.should.equal('{"foo": "bar"}\n')

  it 'should serve not-matched.js when /not-matched.js is requested', ->
    chai.request(@app).get('/not-matched.js').then (res) ->
      res.should.have.status(200)
      res.should.be.javascript

  it 'should error when /not-matched is requested', ->
    chai.request(@app).get('/not-matched').then null, (res) ->
      res.should.have.status(404)

  it 'should correctly handle nested directories', ->
    chai.request(@app).get('/nested/wow').then (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>wow</p>\n")

  it 'should correctly handle directory indices', ->
    chai.request(@app).get('/nested').then (res) ->
      res.should.have.status(200)
      res.should.be.html
      res.text.should.equal("<p>nested</p>\n")
