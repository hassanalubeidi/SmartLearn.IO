// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require_tree .
//= require cocoon

//= require turbolinks


$(document)
  .ready(function() {
    $('.overlay')
      .visibility({
        type   : 'fixed',
        offset : 15 // give some space from top of screen
      })
    ;

    $('.filter.menu .item')
      .tab()
    ;
    $('.popup-add')
      .popup()
    ;

    $('.ui.rating')
      .rating({
        clearable: true
      })
    ;
    
    $('.ui.sidebar')
      .sidebar('attach events', '.launch.button')
    ;

    $('.ui.dropdown')
      .dropdown()
    ;
    
    $('.ui.checkbox')
	  .checkbox()
	;
	$('.message .close').on('click', function() {
	  $(this).closest('.message').fadeOut();
	});
	$('.ui.sidebar').sidebar('attach events', '.sidebar-open');
	$('.ui.sidebar')
	  .sidebar('attach events', '#sidebar-open')
	;
  })
;