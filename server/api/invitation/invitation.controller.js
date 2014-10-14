'use strict';

var _ = require('lodash');
var config = require('../../config/environment');
var Invitation = require('./invitation.model'),
    EventSeries = require('../eventseries/eventseries.model');
var Email = require('../../components/mail');
var auth = require('../../auth/auth.service');

// Get a single invitation
exports.show = function(req, res) {
  Invitation.findOne({'uuid': req.params.id}).populate('eventseries').exec(function (err, invitation) {
    if(err) { return handleError(res, err); }
    if(!invitation) { return res.send(404); }

    // find the eventseries of the invitation
    EventSeries.findById(invitation.eventseries._id, function(err, eventseries) {
      if(err) { return handleError(res, err); }
      if(!eventseries) { return handleError(res, 'eventseries does not exist'); }

      // add the current user as admin to the eventseries
      eventseries.u_admins = _.union(
        // _.union uses strict equality, so convert ObjectId's to strings first
        _.map(eventseries.u_admins, function(x) { return x.toHexString(); }),
        [ req.user._id.toHexString() ]
      );
      eventseries.save(function (err) {
        if (err) { return handleError(res, err); }

        // remove the invitation
        invitation.remove(function(err) {
          if(err) { return handleError(res, err); }
          return res.json(invitation);
        });
      });
    });
  });
};

// Creates a new invitation in the DB.
exports.create = function(req, res) {
  Invitation.create(req.body, function(err, invitation) {
    if(err) { return handleError(res, err); }

    Email.sendEmail({
      to: invitation.email,
      subject: 'Hello ' + invitation.email,
      text: 'Visit this URL to join: ' + process.env.DOMAIN + '/invitation/' + invitation.uuid
    });

    return res.json(201, invitation);
  });
};

function handleError(res, err) {
  return res.send(500, err);
}
