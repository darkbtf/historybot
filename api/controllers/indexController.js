/*
var clips = require('node-clips');
var env = new clips.Environment();

console.log('jizz');
env.initialize( function() {

  console.log('jizz');
  console.log(__dirname);
  // Load .clp file
  env.load(__dirname+'/animal.clp', function () {
    console.log('jizz');

    // Reset environment and run
    env.reset(function(){

      // Rule firing limit set to 1000
      env.run(1000, function() {

        // Log fact list to console
        console.log(env.facts());

        // Dispose of the CLIPS environment and free memory
        env.dispose(function(){

          res.render('index', { title: 'Express' });
        });
      });
    });
  });
});
*/
module.exports = {

  index: function(req, res, next) {
    res.render('index');
  }

};
