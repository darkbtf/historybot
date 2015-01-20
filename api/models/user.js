
var mongoose = require('mongoose');

var schema = new mongoose.Schema({
    name: String
});

var User = mongoose.model('User', schema);

module.exports = User;
