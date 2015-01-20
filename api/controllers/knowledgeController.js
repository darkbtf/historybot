
var fs = require('fs');

var KNOWLEDGE_PATH = __dirname + '/../../clipfiles/knowledge.clp';

module.exports = {
  index: function(req, res) {
    res.json({ message: 'XD' });
  },
  show: function(req, res) {
    fs.readFile(KNOWLEDGE_PATH, {
      encoding: 'utf8'
    }, function(err, data) {
      res.json({
        content: data
      });
    });
  },
  update: function(req, res) {

    //console.log(req.params);
    //console.log(req.body);

    fs.writeFile(KNOWLEDGE_PATH, req.body.content, function(err) {
      if (err) throw err;
      res.json({ content: req.body.content });
    });
  }
};
