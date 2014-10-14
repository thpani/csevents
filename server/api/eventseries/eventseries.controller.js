'use strict';

var _ = require('lodash');
var Eventseries = require('./eventseries.model');

// Get list of eventseriess
exports.index = function(req, res) {
  Eventseries
    .find()
    .populate('u_admins u_editors')
    .exec(function (err, eventseriess) {
      if(err) { return handleError(res, err); }
      return res.json(200, eventseriess);
    });
};

// Get a single eventseries
exports.show = function(req, res) {
  Eventseries
    .findById(req.params.id)
    .populate('u_admins u_editors')
    .exec(function (err, eventseries) {
      if(err) { return handleError(res, err); }
      if(!eventseries) { return res.send(404); }
      return res.json(eventseries);
    });
};

// Creates a new eventseries in the DB.
exports.create = function(req, res) {
  Eventseries.create(req.body, function(err, eventseries) {
    if(err) { return handleError(res, err); }
    return res.json(201, eventseries);
  });
};

// Updates an existing eventseries in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Eventseries.findById(req.params.id, function (err, eventseries) {
    if (err) { return handleError(res, err); }
    if(!eventseries) { return res.send(404); }
    var updated = _.merge(eventseries, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.json(200, eventseries);
    });
  });
};

// Deletes a eventseries from the DB.
exports.destroy = function(req, res) {
  Eventseries.findById(req.params.id, function (err, eventseries) {
    if(err) { return handleError(res, err); }
    if(!eventseries) { return res.send(404); }
    eventseries.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.send(204);
    });
  });
};

function handleError(res, err) {
  return res.send(500, err);
}
