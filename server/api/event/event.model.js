'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var EventSchema = new Schema({
  title: String,
  speaker: String,
  speaker_url: String,
  date_from: Date,
  date_to: Date,
  series: [{ type: Schema.Types.ObjectId, ref: 'EventSeries' }]
});

module.exports = mongoose.model('Event', EventSchema);
