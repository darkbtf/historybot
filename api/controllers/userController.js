
var User = require('../models/User.js');

// TODO (darkbt): all the stuff
module.exports = {

  index: function(req, res) {
    res.send('respond with a resource');
  },

  show: function(req, res) {
    User.findById(req.params.id, function(err, user) {
      res.send(user);
    });
  },

  update: function(req, res) {
    User.findByIdAndUpdate(req.params.id, req.body, { upsert: true}, function(err) {
      res.send(req.body);
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
