$(document).ready(function () {
  load_check_all();
  $('body').on('ifClicked', '#check-all-number', function() {
    var checkbox_list = $('input:checkbox[name="check_number[]"]:enabled');
  
    if ($(this)[0].checked) {
      checkbox_list.iCheck('uncheck');
    } else {
      checkbox_list.iCheck('check');
    }
  });

  $('body').on('ifToggled', 'input:checkbox[name="check_number[]"]', function() {
    load_check_all();
  });
  
  $('body').on('click','.page-btn',function(){
    tbtn_click($(this).find('button'));
  });
});

function load_check_all() {
  var checkbox_list = $('body').find('input:checkbox[name="check_number[]"]:enabled');
  var count = 0;

  checkbox_list.each(function() {
    if (this.checked) {
      count++;
    }
  });

  if (count === checkbox_list.length) {
    $('#check-all-number').iCheck('check');
  } else {
    $('#check-all-number').iCheck('uncheck');
  }
}
