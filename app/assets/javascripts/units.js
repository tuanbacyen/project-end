$(document).ready(function() {
  setup_time_start();
  setup_time_end();
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
