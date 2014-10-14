'use strict';

var uuid = require('node-uuid'),
    mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var InvitationSchema = new Schema({
  email: String,
  privilege: String,
  eventseries: { type: Schema.Types.ObjectId, ref: 'EventSeries' },
  uuid: { type: String, default: uuid.v4 }
});

module.exports = mongoose.model('Invitation', InvitationSchema);
