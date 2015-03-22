# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery -> 
	module_packs = $('#module_pack_topic').html()
	$("#subject").change ->
		subject = $('#subject :selected').text()
		options = $(module_packs).filter("optgroup[label='#{subject}']").html()
		if options 
			$("#module_pack_topic").html(options)
		else
			$("#module_pack_topic").empty()
	$('.ui.accordion').accordion()