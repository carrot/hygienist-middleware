module.exports = (opts) ->

  return (req, res, next) ->
    console.log req.url
    next(opts)
