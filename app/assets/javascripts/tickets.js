$(document).ready(function(){

  $('.ticket_vote').submit(function(){
    $.post($(this).attr("action"), $(this).serialize(), null, "script");
    
    return false;
  })

  $('.up_submit').click(function(){
    $('.up_submit').toggleClass("upvote_clicked");
    $('.down_submit').toggleClass("downvote_clicked");
  });

  $('.down_submit').click(function(){
    $('.up_submit').toggleClass("upvote_clicked");
    $('.down_submit').toggleClass("downvote_clicked");
  });
  
});