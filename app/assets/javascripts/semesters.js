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
    show_update_all();
  });

  $('body').on('click', '.create-class', function(){
    var tr = $(this).closest('tr');
    if(check_class_name_lenght(tr.find('#name_class').val())){
      alert('Tên lớp dài quá 10 ký tự');
    } else if(check_teacher_exist(tr.find('.select_teacher').val())){
      alert('Giáo viên đã là chủ nhiệm');
    } else if(check_class_name_exist(tr.find('#name_class').val())) {
      alert('Tên lớp học đã tồn tại trong học kỳ')
    }
    else {
      var data = {
        auto_create: tr.find('#auto_subject')[0].checked,
        classroom: {
          semester_id: $('#semester_hidden').text(),
          user_id: tr.find('.select_teacher').val(),
          number: tr.find('#select_num').val(),
          name: tr.find('#name_class').val()
        }
      };
      send_ajax_new_semester('POST', '/new_semesters', data, null, $(this).closest('tr'));
    }
  });

  $('body').on('click', '.destroy-class', function(){
    $(this).closest('tr').remove();
    show_update_all();
  });

  $('body').on('change', '#select_num', function(){
    var tr = $(this).closest('tr');
    tr.find('#name_class').val($("option:selected", $(this)).text());
  });
});

function check_teacher_exist(teacher_id){
  var count = 0;
  $('td[data-tid]').each(function(){
    if($(this).data('tid').toString() == teacher_id.toString()){
      count++;
    }
  });
  if (count > 0)
    return true;
  else
    return false;
}

function check_class_name_lenght(name){
  if(name.length > 10)
    return true;
  else
    return false;
}

function check_class_name_exist(name){
  var count = 0;
  $('td[id="class_name"]').each(function(){
    var class_name = this.textContent;
    if(class_name == "")
      class_name = $(this).find('#name_class').val();
    if(class_name == name)
      count++;
  });
  if(count > 1)
    return true;
  else
    return false;
}

function show_update_all(){
  return;
  var btn_update = '<button class="btn btn-info pull-right" id="update_all"><i class="fa fa-save"></i>Update all</button>';
  var checkbox_list = $('body').find('input:checkbox[id="auto_subject"]');
  var count = 0;
  
  checkbox_list.each(function() {
    count++;
  });
  
  $('#update_all').remove();
  if (count > 1) {
    $('#bar_list_class').append(btn_update);
  }
}

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
          <td id="class_name"><input class="form-control" type="text" value="Lớp 1" id="name_class"></td>\
          <td><select class="chosen-select select_teacher" id="select_teacher_'+ count_max +'"></select></td>\
          <td><input type="checkbox" class="icheck-me" name="auto" id="auto_subject" checked data-skin="square" data-color="blue">\
          <strong> auto create subject</strong></td>\
          <td><button class="btn btn-success create-class">\
          <i class="fa fa-save"></i></button>\
          <button class="btn btn-default destroy-class">\
          <i class="fa fa-times-circle"></i></button></td></tr>';
}

function render_tr_result(tr){
  var select_teacher = "#select_teacher_" + tr.find('#index_class').text();
  return '<tr><td id="index_class">'+ tr.find('#index_class').text() +'</td>\
          <td>'+ tr.find('#select_num option:selected').text() +'</td>\
          <td id="class_name">'+ tr.find('#name_class').val() +'</td>\
          <td data-tid="'+ tr.find('.select_teacher').val() +'">'+ tr.find(select_teacher + ' option:selected').text() +'</td>\
          <td>0</td><td>0</td></tr>';
}

function send_ajax_new_semester(method, url, data, id, tr_result){
  $.ajax({
    type: method,
    url: url,
    dataType: 'json',
    data: data,
    success: function(data){
      if(id == null){
        if(data['notifi'].type == "1"){
          var tbl = $('#tbl_class').find('tbody');
          tbl.append(render_tr_result(tr_result));
          tr_result.remove();
          show_update_all();
        } else {
          alert('You need F5');
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
