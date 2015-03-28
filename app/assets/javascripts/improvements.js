$(function() {                       //run when the DOM is ready
  $(".review").click(function() {  //use a class, since your ID gets mangled
    $(this).addClass("loading");      //add the class to the clicked element
    console.log("yup");

    $(this).delay(1000).queue(function(){
        $(this).removeClass('loading').clearQueue();
        $(this).addClass("disabled").clearQueue();
    });
  });

    


    $('.ui.search').search({ source: $('#improvement_topic_name').data('autocomplete-source') });

  });