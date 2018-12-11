$( document ).ready(function() {
  $('#detail-not-input').hide();
  $('.toggle').click(function() {
    $input = $(this);
    $target = $('#'+$input.attr('data-toggle'));
    $target.slideToggle();
  });
});
