$(function(){
  console.log($('.member-message_content').children().first().outerHeight(true));
  $('.member-message_content').each(function(){
    if ($(this).children().first().outerHeight(true) > 100) {
      $(this).after("<a href='#' class='message-read-more' data-toggle='modal' data-target='#messageModal-"+$(this).data('id')+"'><p>Read More...</p></a>");
    }
  });
});