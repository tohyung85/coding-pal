$(function(){
  $('.group-box').mouseover(function(){
    $(this).find('.group-front').addClass('hidden');
    $(this).find('.group-back').removeClass('hidden');
  });

  $('.group-box').mouseout(function(){
    $(this).find('.group-front').removeClass('hidden');
    $(this).find('.group-back').addClass('hidden');
  });
});