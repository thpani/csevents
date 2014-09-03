'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var EventSchema = new Schema({
  title: String,
  speaker: String,
  speaker_url: String,
  date_from: Date,
  date_to: Date
});

module.exports = mongoose.model('Event', EventSchema);
