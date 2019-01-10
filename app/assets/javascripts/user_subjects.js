$(document).ready(function(){
  $('#dialog').dialog({
    autoOpen: false,
    modal: true,
    close: false
  });

  $('#list-subject, #list-subject-teacher').sortable({
    connectWith: '.connectedSortable'
  }).disableSelection();

  $('body').on('click','#submit-user-subject',function(){
    var subject_ids = [];
    $('#list-subject-teacher li').each(function(i){
      subject_ids.push($(this).attr('id'));
    });
    var teacher_id = window.location.search.split('user_id=')[1];
    send_ajax_user_subjects('POST', '/user_subjects', {subject_ids: subject_ids, user_id: teacher_id});
  });

  $('.list-group-item').on('mouseover', function(event) {
    event.preventDefault();
    $(this).closest('li').addClass('open');
  });
  
  $('.list-group-item').on('mouseout', function(event) {
    event.preventDefault();
    $(this).closest('li').removeClass('open');
  });
});

function send_ajax_user_subjects(method, url, data){
  $.ajax({
    type: method,
    url: url,
    dataType: 'json',
    data: data,
    success: function(data){
      if(data.resutl == 0){
        show_notify('user-subject-noti', 1, 'Success', '/user_subjects');
      } else {
        load_dialog('<div>Have a '+ data.resutl +' error. Auto refresh in <span id="countdown">5</span>s</div>');
        var counter = 5;
        var timer = setInterval(function () {
          $('#countdown').text(''+counter);
          counter -= 1;
          if (counter < 0) 
          {
            clearInterval(timer);
          }
        }, 1000);
        setTimeout(function(){
          location.reload();
        }, 5000);
      }
    },
    error: function (error){
      console.log(error);
      alert('has an error');
    }
  });
}
