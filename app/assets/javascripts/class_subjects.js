$(document).ready(function () {
  load_check_all();
  $('body').on('ifClicked', '#check-all-class-subject', function() {
    var checkbox_list = $('input:checkbox[name="check_class_subject[]"]:enabled');
  
    if ($(this)[0].checked) {
      checkbox_list.iCheck('uncheck');
    } else {
      checkbox_list.iCheck('check');
    }
  });

  $('body').on('ifToggled', 'input:checkbox[name="check_class_subject[]"]', function() {
    load_check_all();
  });

  $('body').on('click', '#submit-class-subject', function() {
    
  });
});

function load_check_all() {
  var checkbox_list = $('body').find('input:checkbox[name="check_class_subject[]"]:enabled');
  var count = 0;

  checkbox_list.each(function() {
    if (this.checked) {
      count++;
    }
  });

  if (count === checkbox_list.length) {
    $('#check-all-class-subject').iCheck('check');
  } else {
    $('#check-all-class-subject').iCheck('uncheck');
  }
}
