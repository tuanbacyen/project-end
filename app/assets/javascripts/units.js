$(document).ready(function() {
  setup_time_start();
  setup_time_end();
  if (window.location.pathname.includes('new_auto_unit')){
    var morning = ['#list_unit_morning', '#morning_time_start', '#morning_time_end', '#morning_time_relax',
                  '#morning_time_unit', '#morning_count_unit'];
    var afternoon = ['#list_unit_afternoon', '#afternoon_time_start', '#afternoon_time_end', '#afternoon_time_relax',
                  '#afternoon_time_unit', '#afternoon_count_unit'];
    setup_time();
    unit_create(morning);
    unit_create(afternoon);
    $('body').on('change', '#morning_time_relax, #morning_time_unit, #morning_count_unit', function(){
      unit_create(morning);
    });
    $('body').on('change', '#afternoon_time_relax, #afternoon_time_unit, #afternoon_count_unit', function(){
      unit_create(afternoon);
    });
  }
});

function setup_time_start() {
  $('#time_start_picker').datetimepicker({
    format: 'HH:mm:00'
  }).on('dp.hide', function(e) {
    change_time_end();
  });
}

function setup_time_end() {
  $('#time_end_picker').datetimepicker({
    format: 'HH:mm:00'
  }).on('dp.hide', function(e) {
    if (check_start_end() == false){
      alert('Time start do not less than time end');
      change_time_end();
    }
  });
}

function setup_time() {
  $('.time_picker').datetimepicker({
    format: 'HH:mm:00'
  }).on('dp.hide', function(e) {
    $(this).val();
  });
}

function change_time_end(){
  var start_time = $('#time_start_picker').val().split(':');
  var d = new Date();
  d.setHours(start_time[0],start_time[1],0,0);
  var newDateObj = new Date(d.getTime() + 45*60000);
  var new_str_time = newDateObj.getHours() + ":" + newDateObj.getMinutes() + ":00";
  $('#time_end_picker').val(new_str_time);
}

function check_start_end(){
  var start_total = toSecond($('#time_start_picker').val().split(':'));
  var end_total = toSecond($('#time_end_picker').val().split(':'));
  if (start_total > end_total){
    return false;
  }
  return true;
}

function toSecond(time) {
  return (+time[0]) * 3600 + (+time[1]) * 60 + (+time[2])
}

function unit_create(arrayElement) {
  var list_unit = $(arrayElement[0]);
  var time_start = $(arrayElement[1]).val().split(':').map(Number);
  var time_end = $(arrayElement[2]).val().split(':').map(Number);
  var time_relax = parseInt($(arrayElement[3]).val());
  var time_unit = parseInt($(arrayElement[4]).val());
  var count_unit = parseInt($(arrayElement[5]).val());
  var time_start = time_start[0]*3600 + time_start[1]*60;
  var total = time_end[0]*3600 + time_end[1]*60 - time_start;
  list_unit.html('');
  if ((total - time_relax*(count_unit-1)*60 - time_unit*count_unit*60) < 0) {
    $('#submit_unit').hide();
    list_unit.append('<i class="myerror" style="color:red;">Thời gian lựa chọn không hợp lý</i>');
  } else if($('i[class="myerror"]').length == 0) {
    $('#submit_unit').show();
  }
  for(var i = 0; i < count_unit; i++) {
    var start = time_start + i*(time_unit + time_relax)*60;
    var end = start + time_unit*60;
    var relax = end + time_relax*60;
    var s1 = 'Tiết '+ (i+1) +' : '+ start.toHHMMSS() +' - '+ end.toHHMMSS();
    var s2 = '- - - - - -relax : '+ end.toHHMMSS() +' - '+ relax.toHHMMSS();
    if(i==count_unit -1)
      s2 = '';
    list_unit.append('<li> ' +s1 + s2+ '</li>');
  }
}

