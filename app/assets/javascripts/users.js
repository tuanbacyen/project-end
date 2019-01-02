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

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        $('#img-prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

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

  $( ".add_lesson" ).hide();

  $('.add_form').click(function(){
    $('.add_lesson').toggle();
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
