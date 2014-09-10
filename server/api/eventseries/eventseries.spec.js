'use strict';

var should = require('should');
var app = require('../../app');
var request = require('supertest');

describe('GET /api/eventseries', function() {

  it('should respond with 401 Unauthorized', function(done) {
    request(app)
      .get('/api/eventseries')
      .expect(401)
      .end(function(err, res) {
        if (err) return done(err);
        done();
      });
  });
});
