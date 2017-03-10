$(document).ready(function() {

  // SIDE MENU
  $('#nav-menu').click(function() {
    $('.side-menu').fadeToggle('fast');
  })

  $(document).click(function(e) {
    if($(".side-menu").is(":visible"))
    if(!$(".side-menu").is(e.target))
    if(!$(".side-menu").find('*').is(e.target))
    if(!$("#nav-menu").is(e.target))
      $('.side-menu').fadeToggle('fast');
  });

  // FLASH
  $('.dismiss').click(function(){
    $('.flash').hide();
  });

  // POSTS
  $('#new-post-btn').click(function() {
    console.log('click')
    $('#new-post-btn').hide();
    $('#new_post').show();
  })

  $('#cancel-new-post').click(function() {
    $('#new-post-btn').show();
    $('#new_post').hide();
  });

  // REPLIES
  $('.new-reply-btn').click(function() {
    $('.new-reply-btn').hide();
    $('#new_reply').show();
    $("html, body").animate({ scrollTop: $(document).height() }, "slow");
      return false;
  });

  $('#cancel-new-reply').click(function() {
    $('.new-reply-btn').show();
    $('#new_reply').hide();
  });

  // USER POSTS
  setPosts = function(url) {
    console.log(url)
    $.ajax({
      url: url,
      type: 'POST'
    }).done(function(data) {
      $('#posts').html(data);
      window.history.replaceState(null, null, url);
    }).fail(function(error) {
    });
  };

  var href = window.location.href;
  if (href.match(/users/) && href.match(/posts/) && href.match(/(sign_in|sign_up|password)/) == null) {
    url = window.location.pathname + window.location.search
    setPosts(url)

    $("#posts").on("click", ".pagination a", function(e){
      e.preventDefault();
      url = $(this).attr('href')
      setPosts(url)
      $('html, body').animate({ scrollTop: 0 }, 'slow');
    });
  }

  // USER REPLIES

  setReplies = function(url) {
    $.ajax({
      url: url,
      type: 'POST'
    }).done(function(data) {
      $('#replies').html(data);
      window.history.replaceState(null, null, url);
    }).fail(function(error) {
    });
  };

  if (href.match(/users/) && href.match(/replies/) && href.match(/(sign_in|sign_up|password)/) == null) {
    url = window.location.pathname + window.location.search
    setReplies(url)

    $('#replies').on("click", ".pagination a", function(e){
      e.preventDefault();
      url = $(this).attr('href')
      setReplies(url)
      $('html, body').animate({ scrollTop: 0 }, 'slow');
    });
  };

  // USER VEHICLE

  $('#new-vehicle-btn').click(function(){
    $('#new_vehicle').show();
    $('#new-vehicle-btn').hide();
  });

  $('#cancel-new-vehicle').click(function() {
    $('#new_vehicle').hide();
    $('#new-vehicle-btn').show();
  });

  $('.edit-vehicle-btn').click(function() {
    var form = $(this).parent().find('.edit_vehicle');
    var editButton = $(this);
    $(editButton).hide();
    $(form).show();
    $(this).parent().find('.cancel-edit-vehicle').click(function() {
      $(form).hide();
      $(editButton).show();
    });
  });

  // EDIT POST 
  $('.edit-post-btn').click(function() {
    $('#edit-post').show();
    $(this).hide();

  })

  $('.cancel-edit-post').click(function() {
    $('#edit-post').hide();
    $('.edit-post-btn').show();
  })

  // EDIT REPLY 
  $('.edit-reply-btn').click(function() {
    $(this).parent().parent().find('.edit-reply').show();
    $(this).hide();
  })

  $('.cancel-edit-reply').click(function() {
    $(this).parent().parent().hide();
    $(this).parent().parent().parent().find('.edit-reply-btn').show();
  })

  // SEARCH

  searchPagination = function(url, type) {
    $.ajax({
      url: url,
      type: 'POST'
    }).done(function(data) {
      if(type === 'replies') {
        $('#replies').html(data);
        $('.search-results').each(function(){
          var re = new RegExp(searchTerm, 'ig')
          $(this).html($(this).html().replace(re, "<strong>" + searchTerm + "</strong>"));
        });
      } else if(type === 'posts')
        $('#posts').html(data);
    })
  };

  if (href.match(/search/) && searchTerm) {
    postsUrl = window.location.pathname + '/posts/'
    repliesUrl = window.location.pathname + '/replies/'
    searchPagination(postsUrl, 'posts')
    searchPagination(repliesUrl, 'replies')


    $('#replies').on("click", ".pagination a", function(e){
      e.preventDefault();
      url = $(this).attr('href')
      searchPagination(url, 'replies')
    });

    $('#posts').on("click", ".pagination a", function(e){
      e.preventDefault();
      url = $(this).attr('href')
      searchPagination(url, 'posts')
    });
  };

});
