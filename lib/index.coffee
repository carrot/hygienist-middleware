path      = require 'path'
fs        = require 'fs'
url       = require 'url'
minimatch = require 'minimatch'
_static   = require 'serve-static'
_         = require 'lodash'

###*
 * Configures options and returns a middleware function.
 *
 * Options:
 * - extensions: Paths to represent as clean urls. Default '*.html'
 *
 * @param  {String} dir - path to the root directory to server
 * @param  {Object} opts - options object, described above
 * @return {Function} middleware function
###

module.exports = (root, opts = {}) ->
  return (req, res, next) ->
    url = url.parse(req.url)
    extension = path.extname(url.pathname)
    targets = Array.prototype.concat(opts.extensions || '*.html')

    if extension.length
      if _.any(targets, minimatch.bind(@, (path.basename(url.pathname))))
        res.statusCode = 302
        res.setHeader('Location', req.url.replace(extension,''))
        return res.end()
    else
      test = locate_file(root, url.pathname, targets)
      if test then req.url = test

    next()

###*
 * Tests whether a file exists at a given path with a certain extension.
 *
 * @private
 * @param  {String} root - the base root to look for the file
 * @param  {String} _path - specific file path
 * @param  {Array} extensions - the extension opts to match files
 * @return {Boolean} whether the file exists or not
###

locate_file = (root, _path, extensions) ->
  extensions.some (ext) ->
    return false if _path.substr(_path.length - 1) == '/'
    extension = path.extname(ext)
    file = path.join(root, _path + extension)
    @out = if fs.existsSync(file) then _path + extension else false

  return @out
