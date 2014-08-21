$(document).ready(function(){

  $('.ticket_vote').submit(function(){
    $.post($(this).attr("action"), $(this).serialize(), null, "script");
    return false;
  })
  
});