var gulp        = require('gulp'),
    gulpif      = require('gulp-if'),
    jade        = require('gulp-jade'),
    sass        = require('gulp-sass'),
    markdown    = require('gulp-markdown'),
    csso        = require('gulp-csso'),
    coffee      = require('gulp-coffee'),
    uglify      = require('gulp-uglify'),
    concat      = require('gulp-concat'),
    sourcemaps  = require('gulp-sourcemaps'),
    connect     = require('connect'),
    serveStatic = require('serve-static');

gulp.task('template', function() {
  return gulp.src('src/*.jade')
    .pipe(jade({pretty: true}))
    .pipe(gulp.dest('dist/'))
    ;
});
gulp.task('template-build', function() {
  return gulp.src('src/*.jade')
    .pipe(jade())
    .pipe(gulp.dest('dist/'))
    ;
});

gulp.task('css', function() {
  return gulp.src('./src/css/*.scss')
    .pipe(sourcemaps.init())
    .pipe(
      sass({
        includePaths: ['./src/css'],
        outputStyle: 'nested',
        errLogToConsole: true
      }))
    .pipe(sourcemaps.write('../maps'))
    .pipe(gulp.dest('./dist/css/'))
    ;
});
gulp.task('css-build', function() {
  return gulp.src('./src/css/*.scss')
    .pipe(sourcemaps.init())
    .pipe(
      sass({
        includePaths: ['./src/css'],
        errLogToConsole: true
      }))
    .pipe(csso())
    .pipe(sourcemaps.write('../maps'))
    .pipe(gulp.dest('./dist/css/'))
    ;
});

gulp.task('js', function() {
  return gulp.src(['./src/js/*.coffee', './src/js/*.js'])
    .pipe(sourcemaps.init())
    .pipe(gulpif(/[.]coffee$/, coffee()))
    .pipe(concat('all.min.js'))
    .pipe(sourcemaps.write('../maps'))
    .pipe(gulp.dest('./dist/js/'))
    ;
});
gulp.task('js-build', function() {
  return gulp.src(['./src/js/*.coffee', './src/js/*.js'])
    .pipe(sourcemaps.init())
    .pipe(gulpif(/[.]coffee$/, coffee()))
    .pipe(uglify())
    .pipe(concat('all.min.js'))
    .pipe(sourcemaps.write('../maps'))
    .pipe(gulp.dest('./dist/js/'))
    ;
});

gulp.task('markdown', function() {
  return gulp.src('./src/doc/*.md')
    .pipe(markdown())
    .pipe(gulp.dest('./dist/doc/'))
    ;
});

gulp.task('server', function() {
  return connect().use(serveStatic('./dist')).listen(8080);
});

gulp.task('watch', function () {
  gulp.watch('src/css/*.scss',['css']);
  gulp.watch('src/js/*.coffee',['js']);
  gulp.watch('src/doc/*.md',['markdown']);
  gulp.watch('src/*.jade',['template']);
});

gulp.task('default', ['js','css','template', 'watch', 'server']);
gulp.task('build', ['js-build','css-build','template-build']);
// vim:set ts=2 sw=2 et:
