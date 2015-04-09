# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery -> 
	
	questions = $('#question_topic_id').html()
	$("#subject").change ->
		subject = $('#subject :selected').text()
		options = $(questions).filter("optgroup[label='#{subject}']").html()
		if options 
			$("#question_topic_id").html(options)
		else
			$("#question_topic_id").empty()

	$('.objectives-modal').modal 'attach events', '#all-objectives'

test = undefined
test = 0
woohoo = undefined
$('.add_fields').click ->
  test += 1
  if test > 0
    woohoo = $('.nested-fields .select .optional').last().attr('id')
    $('#' + woohoo).dropdown()
  return



	

	