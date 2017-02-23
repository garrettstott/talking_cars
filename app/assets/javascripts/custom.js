$(document).ready(function(){
  $('.dismiss').click(function(){
    $('.flash').hide();
  });

  $('#new-post-btn').click(function() {
    $('#new-post-btn').hide()
    $('#new_post').show()
  })

  $('#cancel-new-post').click(function() {
    $('#new-post-btn').show()
    $('#new_post').hide();
  })
});
