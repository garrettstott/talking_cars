$(document).ready(function() {

  var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
  };

  // USER POSTS

  setPosts = function(url) {
    console.log(url)
    $.ajax({
      url: url,
      type: 'POST'
    }).done(function(data) {
      $('#posts').html(data);
      window.history.pushState(null, null, url);
    }).fail(function(error) {
    });
  };

  var href = window.location.href;
  if (href.match(/users/) && href.match(/posts/) && href.match(/(sign_in|sign_up|password)/) == null) {
    url = window.location.pathname + window.location.search
    setPosts(url)

    $("#posts").on("click", ".pagination a", function(e){
      e.preventDefault();
      url = $(e.target).attr('href')
      setPosts(url)
    });
  }



  // USER REPLIES

  setReplies = function(url) {
    console.log(url)
    $.ajax({
      url: url,
      type: 'POST'
    }).done(function(data) {
      $('#replies').html(data);
      window.history.pushState(null, null, url);
    }).fail(function(error) {
    });
  };

  var href = window.location.href;
  if (href.match(/users/) && href.match(/replies/) && href.match(/(sign_in|sign_up|password)/) == null) {
    url = window.location.pathname + window.location.search
    setReplies(url)

    $('#replies').on("click", ".pagination a", function(e){
      console.log('click')
      e.preventDefault();
      url = $(e.target).attr('href')
      setReplies(url)
    });
  };


});
