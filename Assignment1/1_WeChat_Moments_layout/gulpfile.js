var gulp        = require('gulp');
var sass        = require('gulp-ruby-sass');
var browserSync = require('browser-sync').create();

gulp.task('sass', () =>
  sass('./scss/*.scss')
    .on('error', sass.logError)
    .pipe(gulp.dest('./css/'))
);

gulp.task('serve', ['sass'], function() {
  browserSync.init({
    files: "./css/*.css",
  	server: {
  	  baseDir: "./"
  	}
  });
  gulp.watch("./scss/*.scss", ['sass']);
  gulp.watch("./*.html").on('change', browserSync.reload);
});

gulp.task('default', ['serve']);