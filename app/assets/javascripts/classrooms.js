$( document ).ready(function() {
  $('body').on('change','#select-number', function(){
    $('#class-name').val('Lớp ' + $(this).val());
  });
  $('body').on('change','#semester-year', function(){
    var data = {
      semester_id: $(this).val()
    };
    send_ajax_classrooms('POST', '/teacher_can_teach', data);
  });
});

function send_ajax_classrooms(method, url, data){
  $.ajax({
    type: method,
    url: url,
    dataType: 'json',
    data: data,
    success: function(data){
      $("#teacher-has").empty();
      if(data.list_teacher.length > 0){
        for(var i = 0; i < data.list_teacher.length; i++){
          $('#teacher-has').append(`<option value="${data.list_teacher[i][1]}">${data.list_teacher[i][0]}</option>`); 
        }
      }
      $('#teacher-has').trigger("chosen:updated");
    },
    error: function (error){
      console.log(error);
      alert('has an error');
    }
  });
}
