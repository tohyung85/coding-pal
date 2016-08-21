$(function() {
  $('.messaging-button').click(function(){
    var post_url = $(this).data('url');
    $('#new_user_message').attr('action', post_url);
  });
});