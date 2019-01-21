$(document).ready(function() {
  if (window.location.pathname.includes('sign_in') || window.location.pathname.includes('sign_up')){
    $('.wrapper').css('background-color', 'white');
  }

  $('body').on('change','#school_confirmed', function(){
    var data = {
      school_id: $(this).val()
    };
    send_ajax_students('POST', '/student_in_school', data);
  });
  
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

  $('.form-change-pass').hide();
  $('#change_pass').on('click', function() {
    if (this.checked) {
      $('.form-change-pass').show();
      $('.add-required').prop('required', true);
    } else {
      $('.form-change-pass').hide();
      $('.add-required').prop('required', false);
    }
  });

  $('#user_avatar').change(function() {
    let size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert('Maximum file size is 5MB. Please choose a smaller file.');
    } else {
      $('#img-prev').removeClass('hidden');
      $('.img-avatar').addClass('hidden');
      readURL(this);
    }
  });
});

function send_ajax_students(method, url, data){
  $.ajax({
    type: method,
    url: url,
    dataType: 'json',
    data: data,
    success: function(data){
      $("#student_confirmed").empty();
      if(data.list_student.length > 0){
        for(var i = 0; i < data.list_student.length; i++){
          $('#student_confirmed').append(`<option value="${data.list_student[i][1]}">${data.list_student[i][0]}</option>`); 
        }
      }
      $('#student_confirmed').trigger("chosen:updated");
    },
    error: function (error){
      console.log(error);
      alert('has an error');
    }
  });
}
