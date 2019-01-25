$(document).ready(function() {
  setup_daterange();

  $('body').on('click', '#add_new_class', function(){
    var data = {
      semester_id: $('#semester_hidden').text()
    };
    var count_max = get_count_max();
    var tbl = $('#tbl_class').find('tbody');
    tbl.prepend(render_tr(count_max));
    set_up_chosen();
    icheck();
    send_ajax_new_semester('POST', '/teacher_can_teach', data, '#select_teacher_'+ count_max);
  });

  $('body').on('click', '.create-class', function(){
    var tr = $(this).closest('tr');
    var data = {
      auto_create: tr.find('#auto_subject')[0].checked,
      classroom: {
        semester_id: $('#semester_hidden').text(),
        user_id: tr.find('.select_teacher').val(),
        number: tr.find('#select_num').val(),
        name: tr.find('#name_class').val()
      }
    };
    send_ajax_new_semester('POST', '/new_semesters', data, null);
  });

  $('body').on('click', '.destroy-class', function(){
    $(this).closest('tr').remove();
  });
});

function select_num(){
  result = '<select class="chosen-select" id="select_num">';
  for(var i=1; i<=12; i++){
    result += '<option value="'+ i +'">Lớp '+ i +'</option>';
  }
  return result + '</select>';
}

function get_count_max() {
  var max = 0;
  $('td[id="index_class"]').each(function(){
    if(parseInt(this.textContent) > max)
      max = parseInt(this.textContent);
  });
  return max + 1;
}

function render_tr(count_max){
  return '<tr><td id="index_class">'+ count_max +'</td>\
          <td>'+ select_num() +'</td>\
          <td><input class="form-control" type="text" value="Lớp 1" id="name_class"></td>\
          <td><select class="chosen-select select_teacher" id="select_teacher_'+ count_max +'"></select></td>\
          <td><input type="checkbox" class="icheck-me" name="auto" id="auto_subject" checked data-skin="square" data-color="blue"><br></td>\
          <td><button class="btn btn-success create-class">\
          <i class="fa fa-save"></i></button>\
          <button class="btn btn-default destroy-class">\
          <i class="fa fa-times-circle"></i></button></td></tr>';
}

function send_ajax_new_semester(method, url, data, id){
  $.ajax({
    type: method,
    url: url,
    dataType: 'json',
    data: data,
    success: function(data){
      if(id == null){
        if(data['notifi'].type == "1"){
          // chua xong
        } else {
          // chua xong
        }
        show_notify('new_semester', data['notifi'].type, data['notifi'].message, '')
      } else {
        callback_select(data, id);
      }
    },
    error: function (error){
      console.log(error);
      alert('has an error');
    }
  });
}

function callback_select(data, id){
  var select = $(id);
  select.empty();
  if(data.list_teacher.length > 0){
    for(var i = 0; i < data.list_teacher.length; i++){
      select.append(`<option value="${data.list_teacher[i][1]}">${data.list_teacher[i][0]}</option>`); 
    }
  }
  select.trigger("chosen:updated");
}

function setup_daterange() {
  $('.start-to-end .input-daterange').datepicker({
    clearBtn: true,
    language: I18n.locale,
    daysOfWeekDisabled: '0,6',
    todayHighlight: true,
    orientation: 'bottom auto',
    format: I18n.t('date-js')
  }).on('hide', function(e) {
    var start_date = new Date($('input[name="semester[start_date]"]').val());
    var end_date = new Date($('input[name="semester[end_date]"]').val());
    var end_month = end_date.getMonth();
    start_date = start_date.getFullYear();
    end_date = end_date.getFullYear();
    if (start_date == end_date && end_month > 6){
      end_date += 1;
    } else {
      start_date = end_date - 1;
    }
    if (isNaN(start_date) || isNaN(end_date)){
      $('input[name="semester[school_year]"]').val('');
    } else {
      $('input[name="semester[school_year]"]').val(start_date + ' - ' + end_date);
    }
  });
}
