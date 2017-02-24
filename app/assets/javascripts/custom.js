$(document).ready(function(){
  
  $('.dismiss').click(function(){
    $('.flash').hide();
  });

  $('#new-post-btn').click(function() {
    $('#new-post-btn').hide();
    $('#new_post').show();
  })

  $('#cancel-new-post').click(function() {
    $('#new-post-btn').show();
    $('#new_post').hide();
  });

  $('#new-reply-btn').click(function() {
    $('#new-reply-btn').hide();
    $('#new_reply').show();
    $("html, body").animate({ scrollTop: $(document).height() }, "slow");
      return false;
  });

  $('#cancel-new-reply').click(function() {
    $('#new-reply-btn').show();
    $('#new_reply').hide();
  });

  $('#new-vehicle-btn').click(function(){
    $('#new_vehicle').show();
    $('#new-vehicle-btn').hide();
  });

  $('#cancel-new-vehicle').click(function() {
    $('#new_vehicle').hide();
    $('#new-vehicle-btn').show();
  });

});
