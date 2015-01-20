
var express = require('express');
var router = express.Router();

// TODO: refactor the 'require' lines in a more extendable way.
var CONTROLLER_PATH = '../api/controllers/';
var index = require(CONTROLLER_PATH + 'indexController.js');
var knowledge = require(CONTROLLER_PATH + 'knowledgeController.js');
var problem = require(CONTROLLER_PATH + 'problemController.js');

// home
router.get('/', index.index);

// user
router.get('/users', user.index);
router.get('/user/new', user.new);
router.put('/user/:id?', user.update);
router.get('/user/:id?', user.show);

// knowledge
router.get('/knowledge', knowledge.show);
router.post('/knowledge', knowledge.update);

// problem
router.get('/problems', problem.index);
router.post('/problem', problem.update);
router.get('/problem/:id', problem.show);
router.post('/problem/:id', problem.updateClips);
router.get('/run/:id', problem.run);

module.exports = router;
