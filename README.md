# hygienist

[![npm](http://img.shields.io/npm/v/hygienist.svg?style=flat)](https://badge.fury.io/js/hygienist) [![tests](http://img.shields.io/travis/carrot/hygienist/master.svg?style=flat)](https://travis-ci.org/carrot/hygienist) [![dependencies](http://img.shields.io/gemnasium/carrot/hygienist.svg?style=flat)](https://david-dm.org/carrot/hygienist)

Providing clean urls for static sites since 1776

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why should you care?

Let's say that you are using [connect](https://github.com/senchalabs/connect) to serve a static site. You might have pages like `about.html`, `foobar.html`, etc. When using connect's default static router, you'll see the full `.html` extension at the end of each of these pages. But really, that's not necessary for the user to see or have to type in, it would be better to go to `http://example.com/about` than `http://example.com/about.html`. This is exactly what hygienist does -- it removes the file extensions and just uses the filename as the route. How convenient!

### Installation

`npm install hygienist --save`

### Usage

Most basic usage example:

```js
var http = require('http');
    connect = require('connect'),
    hygienist = require('hygienist');

var app = connect().use(hygienist());

var server = http.createServer(app).listen(1111)
```

If there are some files that you want to be served with their extension, you can pass in a `whitelist` option, which is a globstar string or array of globstar strings for files you want hygienist to ignore. For example, if we wanted to serve json files with the extension intact:

```js
hygienist({ whitelist: '*.json' })
```

That's it! If you have other ideas or ways you'd like to use hygienist, we'd love to hear them, just open an issue or pull request!

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
