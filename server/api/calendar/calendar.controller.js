'use strict';

var _ = require('lodash');
var icalendar = require('icalendar');
var Event = require('../event/event.model'),
    Eventseries = require('../eventseries/eventseries.model');

// Get a single eventseries
exports.show = function(req, res) {
  Eventseries.findOne({cal_pub_id: req.params.id}, function (err, eventseries) {
    if(err) { return handleError(res, err); }
    if(!eventseries) { return res.send(404); }

    var ical = new icalendar.iCalendar();

    Event.find({series: eventseries._id}, function(err, events) {
      if(err) { return handleError(res, err); }

      _.each(events, function(evt) {
        console.log(evt);
        var icalEvent = ical.addComponent('VEVENT');
        icalEvent.setSummary(evt.title);
        icalEvent.setDate(evt.date_from, evt.date_to);
      });

      res.set('Content-Type', 'text/calendar');
      return res.send(200, ical.toString());
    });
  });
};

function handleError(res, err) {
  return res.send(500, err);
}
