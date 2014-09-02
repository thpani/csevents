'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var EventSchema = new Schema({
  title: String,
  date_from: Date,
  date_to: Date
});

module.exports = mongoose.model('Event', EventSchema);
