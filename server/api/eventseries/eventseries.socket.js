/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Eventseries = require('./eventseries.model');

exports.register = function(socket) {
  Eventseries.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  Eventseries.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('eventseries:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('eventseries:remove', doc);
}