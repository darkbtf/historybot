var gulp = require('gulp');
var browserify = require('gulp-browserify');
var nodemon = require('gulp-nodemon');
var jshint = require('gulp-jshint');
var uglify = require('gulp-uglify');
var port = process.env.port || 3000;

gulp.task('browserify', function() {
  gulp.src('./public/javascript/src/app.js')
    .pipe(browserify({ transform: 'reactify' }))
    .pipe(uglify())
    .pipe(gulp.dest('./public/javascript/build/'));
});

gulp.task('server', function() {
  nodemon({ script: 'bin/www' });
});

// watch files for live reload
gulp.task('watch', function() {
  gulp.watch('public/javascript/src/**/*.js', ['browserify']);
});

gulp.task('serve', ['browserify', 'server', 'watch']);
