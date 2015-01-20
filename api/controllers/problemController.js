
var Problem = require('../models/Problem.js');

var fs = require('fs');

var KNOWLEDGE_PATH = __dirname + '/../../clipfiles/knowledge.clp';
var PROBLEM_PATH = __dirname + '/../../clipfiles/problems/';

var getProblemPath = function(id) {
  return PROBLEM_PATH + id + '.clp';
}

var clips = require('node-clips');
var env = new clips.Environment();

module.exports = {

  index: function(req, res) {
    Problem.find({}, function(err, problems) {
      res.json(problems);
    });
  },

  show: function(req, res) {
    var id = req.params.id;
    //console.log(id);
    fs.readFile(getProblemPath(id), {
      encoding: 'utf8'
    }, function(err, data) {
      res.json({
        content: data
      });
    });
  },

  run: function(req, res) {

  },

  update: function(req, res) {
    User.findByIdAndUpdate(req.params.id, req.body, { upsert: true }, function(err) {
      res.json(req.body);
    });
  },

  updateClips: function(req, res) {
    var id = req.params.id;
    console.log(req.body);
    fs.writeFile(getProblemPath(id), req.body.content, function(err) {
      if (err) throw err;
      res.json({ content: req.body.content });
    });
  },

  run: function(req, res) {
    var id = req.params.id;
    env.initialize( function() {
      env.load(KNOWLEDGE_PATH, function () {
        console.log(env.facts());
        env.load(getProblemPath(id), function() {
          env.reset(function(){
            env.run(1000, function() {
              var result = JSON.stringify(env.facts(), null, 2);
              console.log(result);
              res.json({
                result: result
              });
            });
          });
        });
      });
    });
  },

  delete: function(req, res) {
    User.findByIdAndRemove(req.params.id, function(err, user) {
      res.send(user);
    });
  },

  new: function(req, res) {
  }

};
