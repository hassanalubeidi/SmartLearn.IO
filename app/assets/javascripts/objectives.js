$(document)
  .ready(function() {
      $(".tab").tab();
      $( ".answer-button" ).on( "click", function() {
        $(".question").dimmer("show");
        $(".hidden.answer").removeClass("hidden");
        $(".hidden.submit").css("display", "block");
        $.tab('change tab', '2');
        this.remove();
      });
      $( ".submit" ).on( "click", function() {
        setTimeout(function(){
      	  $.tab('change tab', '3');
      	}, 1000);
        $(".answer-tab").dimmer('show')
        
        this.remove();
      });
      $( ".hint-button" ).on( "click", function() {
        $(".hidden.hint").removeClass("hidden");
        this.remove();
      });
      $(".done-button").on( "click" , function() {
      	$(".flashcard").dimmer('show');
      });
  });