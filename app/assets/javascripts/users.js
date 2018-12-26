$(document).ready(function() {
  $('#detail-not-input').hide();
  $('.toggle').click(function() {
    $input = $(this);
    $target = $('#'+$input.attr('data-toggle'));
    $target.slideToggle();
  });

  $('body').on('ifClicked', '#check-all-user-confirm', function() {
    var checkbox_list = $('input:checkbox[name="check_user_confirm[]"]:enabled');
  
    if ($(this)[0].checked) {
      checkbox_list.iCheck('uncheck');
    } else {
      checkbox_list.iCheck('check');
    }
  });

  $('body').on('ifToggled', 'input:checkbox[name="check_user_confirm[]"]', function() {
    var checkbox_list = $('body').find('input:checkbox[name="check_user_confirm[]"]:enabled');
    var count = 0;

    checkbox_list.each(function() {
      if (this.checked) {
        count++;
      }
    });

    if (count === checkbox_list.length) {
      $('#check-all-user-confirm').iCheck('check');
    } else {
      $('#check-all-user-confirm').iCheck('uncheck');
    }
  });
});

function send_ajax(method, url, data){
  $.ajax({
    type: method,
    url: url,
    dataType: 'json',
    data: data,
    success: function(data){
    },
    error: function (error){
      alert(error);
    }
  });
}
