'use strict';

var should = require('should');
var app = require('../../app');
var request = require('supertest');

describe('GET /api/events', function() {

  it('should respond with 401 Unauthorized', function(done) {
    request(app)
      .get('/api/events')
      .expect(401)
      .end(function(err, res) {
        if (err) return done(err);
        done();
      });
  });
});
