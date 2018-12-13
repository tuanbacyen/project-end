$(document).ready(function() {
  setTimeout(function() {$('.time-out').hide('slow');}, 3000);

  $('div.alert-notice').addClass('alert-success');
  $('div.alert-alert').addClass('alert-danger');

  $(document).on('click', '.close', function () {$(this).parent().hide();});
  $(document).on('click', '#my-btn', function () {
    show_notify('uno0', 0, '', 'url');
    show_notify('uno1', 1, '', 'url');
    show_notify('uno2', 2, '', 'url');
    show_notify('uno3', 3, '', 'url');
  });
  $(document).on('click', '.notify2', function () {
    window.open($(this).attr('data-url'), '_blank');
    $(this).remove();
  });
});

/**
 *  Show notification
 * 
 *  id: is id off element. No duplicate
 * 
 *  type: type of notify
 * 
 *  0: alert-info, 1: alert-success, 2: alert-warning, 3: alert-danger
 * 
 *  message: you don't know ??
 * 
 *  url: may be it not url
 * */
function show_notify(id, type, message, url) {
  var lst_type = ['alert-info', 'alert-success', 'alert-warning', 'alert-danger']
  $('.my-notify').append('<div id="' + id +'" class="alert ' + lst_type[type] + ' notify2 pointer-add" \
    data-url="' + url + '"><button type="button" class="close">×</button>\
    <p class="line-clamp">' + message + '</p></div>');
  var div_notify = $('#'+id);
  div_notify.delay(0).fadeIn('slow');
  div_notify.delay(50000).fadeOut('slow', function() {$(this).remove();});
}
