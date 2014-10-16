'use strict';

var express = require('express');
var controller = require('./invitation.controller');
var auth = require('../../auth/auth.service');

var bruteforce = require('../../components/brute');

var router = express.Router();

router.get('/:id', auth.isAuthenticated(), controller.show);
router.post('/', auth.isAuthenticated(), bruteforce.prevent, controller.create);

module.exports = router;
