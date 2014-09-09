'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var EventseriesSchema = new Schema({
  name: String,
  info: String
});

module.exports = mongoose.model('Eventseries', EventseriesSchema);
