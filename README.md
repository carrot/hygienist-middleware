# Hygienist Middleware

[![npm](http://img.shields.io/npm/v/hygienist-middleware.svg?style=flat)](https://badge.fury.io/js/hygienist-middleware) [![tests](http://img.shields.io/travis/carrot/hygienist-middleware/master.svg?style=flat)](https://travis-ci.org/carrot/hygienist-middleware) [![dependencies](http://img.shields.io/gemnasium/carrot/hygienist-middleware.svg?style=flat)](https://david-dm.org/carrot/hygienist-middleware)

Providing clean urls for static sites since 1776

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why should you care?

Let's say that you are using [connect](https://github.com/senchalabs/connect) to serve a static site. You might have pages like `about.html`, `foobar.html`, etc. When using connect's default static router, you'll see the full `.html` extension at the end of each of these pages. But really, that's not necessary for the user to see or have to type in, it would be better to go to `http://example.com/about` than `http://example.com/about.html`. This is exactly what hygienist does -- it removes the file extensions and just uses the filename as the route. How convenient!

### Installation

`npm install hygienist-middleware --save`

### Usage

This library can be used with connect, express, and any other server stack that accepts the same middleware format. A very basic usage example:

```js
var http = require('http');
    connect = require('connect'),
    hygienist = require('hygienist-middleware');

var app = connect().use(hygienist('public'));

var server = http.createServer(app).listen(1111)
```

Hygienist *directly extends [serve-static](https://github.com/expressjs/serve-static)*, the default static router in connect and express, so it also acts as a full static file server. Any arguments that you can pass to serve-static, you can also pass to hygienist, and they will work as expected.

By default, hygienist will only serve `.html` files as clean urls. If you would like to change this behavior, you can override via a `clean` option, which is a globstar string or array of globstar strings intended to match files you want hygienist to serve as clean urls. For example, if we wanted to serve both html and json files with clean urls:

```js
hygienist('public', { clean: ['*.html', '*.json'] })
```

That's it! If you have other ideas or ways you'd like to use hygienist, we'd love to hear them, just open an issue or pull request!

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
