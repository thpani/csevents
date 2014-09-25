/**
 * Populate DB with sample data on server start
 * to disable, edit config/environment/index.js, and set `seedDB: false`
 */

'use strict';

var User = require('../api/user/user.model');
var Event = require('../api/event/event.model');
var EventSeries = require('../api/eventseries/eventseries.model');

User.find({}).remove(function() {
  User.create({
    provider: 'local',
    name: 'Test User',
    email: 'test@test.com',
    password: 'test'
  }, {
    provider: 'local',
    role: 'admin',
    name: 'Admin',
    email: 'admin@admin.com',
    password: 'admin'
  }, function(err, u_test, u_admin) {
    console.log('finished populating users');

    EventSeries.find({}).remove(function() {
      EventSeries.create({
        name: 'RiSE Seminar',
        info: 'Seminar for Rigorous Systems Engineering'
      }, {
        name: 'VCLA Lecture Series',
        info: 'Seminar of the Vienna Center for Logic and Algorithms'
      }, function(err, series_rise, series_vcla) {
        console.log('finished populating event series');

        Event.find({}).remove(function() {
          Event.create({
            title: 'Loop Patterns in C Programs',
            speaker: 'Thomas Pani',
            date_from: '2014-09-03T16:00:00.000Z',
            date_to: '2014-09-03T17:00:00.000Z',
            series: [ series_rise._id, series_vcla._id ]
          }, function(err) {
            if (err) throw err;
            console.log('finished populating events');
          });
        });

      });
    });
  });
});
