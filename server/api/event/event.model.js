'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var EventSchema = new Schema({
  title: String,
  date_begin: Date,
  date_end: Date
});

module.exports = mongoose.model('Event', EventSchema);