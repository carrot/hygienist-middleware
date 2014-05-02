var chai = require('chai'),
    http = require('chai-http'),
    path = require('path'),
    hygienist = require('../..');

var should = chai.should();

chai.use(http);

global.hygienist = hygienist;
global.chai = chai;
global.should = should;
global.path = path;
global.base_path = path.join(__dirname, '../fixtures');
