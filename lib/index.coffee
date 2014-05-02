path    = require 'path'
fs      = require 'fs'
url     = require 'url'
_static = require 'serve-static'

###*
 * Configures options and returns a middleware function.
 *
 * Options:
 * - maxAge: Browser cache max age in ms. Default 0
 * - hidden: Allow transfer of hidden files. Default false
 * - redirect: Redirect to trailing / when path is dir. Default true
 * - index: Default filename for directories. Default 'index.html'
 * - clean: Paths to represent as clean urls. Default '*.html'
 *
 * @param  {String} dir - path to the root directory to server
 * @param  {Object} opts - options object, described above
 * @return {Function} middleware function
###

module.exports = (root, opts = {}) ->
  return (req, res, next) ->
    url = url.parse(req.url)
    extension = path.extname(url.pathname)

    if extension.length
      if extension == '.html'
        res.statusCode = 302
        res.setHeader('Location', req.url.replace('.html',''))
        return res.end()
    else
      if exists_with_extension(root, url.pathname, '.html')
        req.url = "#{url.pathname}.html#{if url.search then url.search else ''}"

    _static(root, opts)(req, res, next)

###*
 * Tests whether a file exists at a given path with a certain extension.
 *
 * @private
 * @param  {String} root - root path, joined with
 * @param  {String} _path - specific file path
 * @param  {String} ext - the extension to be added to the file
 * @return {Boolean} whether the file exists or not
###

exists_with_extension = (root, _path, ext) ->
  fs.existsSync("#{path.join(root, _path)}#{ext}")
