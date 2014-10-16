var ExpressBrute = require('express-brute');
var MongoStore = require('express-brute-mongo');
var MongoClient = require('mongoose').mongo;

var config = require('../../config/environment');

var store = new MongoStore(function (ready) {
  MongoClient.connect(config.mongo.uri, function(err, db) {
    if (err) throw err;
    ready(db.collection('bruteforce-store'));
  });
});

module.exports = new ExpressBrute(store);
