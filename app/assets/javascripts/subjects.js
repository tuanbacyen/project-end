$(document).ready(function() {
  $('body').on('ifClicked', '#check-all-subject', function() {
    var checkbox_list = $('input:checkbox[name="check_subject[]"]:enabled');
  
    if ($(this)[0].checked) {
      checkbox_list.iCheck('uncheck');
    } else {
      checkbox_list.iCheck('check');
    }
  });

  $('body').on('ifToggled', 'input:checkbox[name="check_subject[]"]', function() {
    var checkbox_list = $('body').find('input:checkbox[name="check_subject[]"]:enabled');
    var count = 0;

    checkbox_list.each(function() {
      if (this.checked) {
        count++;
      }
    });

    if (count === checkbox_list.length) {
      $('#check-all-subject').iCheck('check');
    } else {
      $('#check-all-subject').iCheck('uncheck');
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
