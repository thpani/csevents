'use strict';

var _ = require('lodash');
var nodemailer = require('nodemailer');

var config = require('../../config/environment');

var transporter = nodemailer.createTransport({
  service: config.email.service,
  auth: {
    user: config.email.user,
    pass: config.email.pass
  }
});

function getEmail(email) {
  var defaults = {
    from: config.email.from
  };
  
  return _.merge(defaults, email);
}

function sendEmail(emailData) {
  var email = getEmail(emailData);

  transporter.sendMail(email, function(error, info) {
    if (error) {
      console.log(error);
    } else {
      console.log('Message sent: ' + info.response);
    }
  });
}

module.exports.sendEmail = sendEmail;
