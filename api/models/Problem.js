
var mongoose = require('mongoose');

var schema = new mongoose.Schema({
  id: String,
  title: String,
});

var User = mongoose.model('Problem', schema);

module.exports = User;
