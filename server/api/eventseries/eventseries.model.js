'use strict';

var uuid = require('node-uuid'),
    mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var EventseriesSchema = new Schema({
  name: String,
  info: String,
  cal_pub_id: { type: String, default: uuid.v4 }
});

module.exports = mongoose.model('EventSeries', EventseriesSchema);
