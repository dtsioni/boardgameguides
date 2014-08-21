$(document).ready(function(){

  $('.ticket_vote').submit(function(){
    $.post($(this).attr("action"), $(this).serialize(), null, "script");
    return false;
  });
  //JS to change colors of arrows based on 2 conditions
  //when they've already voted on before hand
  //and what they are now voting on
  // IS voting UP
  $('.up_submit').click(function(){
    //if they HAVE voted UP already
    if ($('.up_submit').hasClass('upvote_clicked')){
      $('.up_submit').removeClass('upvote_clicked');
    }
    //if they HAVE voted DOWN already
    if ($('.down_submit').hasClass('downvote_clicked')){
      $('.up_submit').addClass('upvote_clicked');
      $('.down_submit').removeClass('downvote_clicked');
    }
    //if they HAVE NOT voted already
    if (!($('.down_submit').hasClass('downvote_clicked') || $('up_submit').hasClass('upvote_clicked'))){
      $('.up_submit').addClass('upvote_clicked');
    }
  });
  //IS voting DOWN
  $('.down_submit').click(function(){
    //if they HAVE voted UP already
    if ($('.up_submit').hasClass('upvote_clicked')){
      $('.up_submit').removeClass('upvote_clicked');
      $('.down_submit').addClass('downvote_clicked');
    }
    //if they HAVE voted DOWN already
    if ($('.down_submit').hasClass('downvote_clicked')){
      $('.down_submit').removeClass('downvote_clicked');
    }
    //if they HAVE NOT voted already
    if (!($('.down_submit').hasClass('downvote_clicked') || $('up_submit').hasClass('upvote_clicked'))){
      $('.down_submit').addClass('downvote_clicked');
    }
  });
  
});