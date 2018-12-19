$(document).ready(function() {
  setup_daterange();
});

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
    start_date = start_date.getFullYear();
    end_date = end_date.getFullYear();
    if (start_date == end_date){
      end_date += 1;
    }
    if (isNaN(start_date) || isNaN(end_date)){
      $('input[name="semester[school_year]"]').val('');
    } else {
      $('input[name="semester[school_year]"]').val(start_date + ' - ' + end_date);
    }
  });;
}
