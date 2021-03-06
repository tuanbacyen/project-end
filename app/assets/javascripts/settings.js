$(document).ready(function() {
  setTimeout(function() {$('.time-out').hide('slow');}, 3000);
  var simplemde = new SimpleMDE({ element: document.getElementById("markdown") });

  active_slide();
  $('div.alert-notice').addClass('alert-success');
  $('div.alert-alert').addClass('alert-danger');
  $('.datatable').DataTable();
  icheck();
  setup_datepiker();
  set_up_chosen();
});

$(document).on('click', '.close', function () {$(this).parent().hide();});
$(document).on('click', '.notify2', function () {
  var url = $(this).attr('data-url');
  if(url != ''){
    window.open(url, '_blank');
    $(this).remove();
  } else {
    return;
  }
});

/**
 *  Show notification
 * 
 *  id: is id off element. No duplicate
 * 
 *  type: type of notify
 * 
 *  0: alert-info, 1: alert-success, 2: alert-warning, 3: alert-danger
 * 
 *  message: you don't know ??
 * 
 *  url: may be it not url
 * */
function show_notify(id, type, message, url) {
  var lst_type = ['alert-info', 'alert-success', 'alert-warning', 'alert-danger']
  $('.my-notify').append('<div id="' + id +'" class="alert ' + lst_type[parseInt(type)] + ' notify2 pointer-add" \
    data-url="' + url + '"><button type="button" class="close">×</button>\
    <p class="line-clamp">' + message + '</p></div>');
  var div_notify = $('#'+id);
  div_notify.delay(0).fadeIn('slow');
  div_notify.delay(5000).fadeOut('slow', function() {$(this).remove();});
}

function icheck(){
  if($(".icheck-me").length > 0){
    $(".icheck-me").each(function(){
      var $el = $(this);
      var skin = ($el.attr('data-skin') !== undefined) ? "_" + $el.attr('data-skin') : "",
      color = ($el.attr('data-color') !== undefined) ? "-" + $el.attr('data-color') : "";
      var opt = {
        checkboxClass: 'icheckbox' + skin + color,
        radioClass: 'iradio' + skin + color,
      }
      $el.iCheck(opt);
    });
  }
}

function active_slide() {
  var url = window.location.pathname + '/';
  $("a[id^='sidebar-item']").each(function(){
    if (url.includes($(this).attr('href')+'/') && url != '/'){
      var child = $(this).parent().addClass('active');
      var parent = child.parent().parent();
      if (parent.hasClass('treeview')) {
        parent.addClass('active');
      }
      return false;
    }
  });
}

function setup_datepiker() {
  $('.input-datetimepiker').datepicker({
    clearBtn: true,
    todayBtn: true,
    language: I18n.locale,
    todayHighlight: true,
    autoclose: true,
    format: I18n.t('date-js')
  });
}

function set_up_chosen() {
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'Result not match',
    width: '100%'
  });
}

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      $('#img-prev').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

function load_dialog(content){
  var dialog = $('#dialog');
  dialog.dialog({
    buttons : {
      'Refresh now' : function() {
        location.reload();
      }
    }
  });
  dialog.html(content);
  dialog.dialog('open');
}

function tbtn_click(btn){
  if(btn.find('i').hasClass('fa-plus-circle') == true) {
    btn.find('i').removeClass('fa-plus-circle');
    btn.find('i').addClass('fa-minus-circle');
    btn.parents("tbody").find(".toggler").addClass("toggler1");
  } else {
    btn.find('i').removeClass('fa-minus-circle');
    btn.find('i').addClass('fa-plus-circle');
    btn.parents("tbody").find(".toggler1").removeClass("toggler1");
  }
}

Number.prototype.toHHMMSS = function () {
  var sec_num = parseInt(this, 10);
  var hours   = Math.floor(sec_num / 3600);
  var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
  var seconds = sec_num - (hours * 3600) - (minutes * 60);

  if (hours   < 10) {hours   = "0"+hours;}
  if (minutes < 10) {minutes = "0"+minutes;}
  if (seconds < 10) {seconds = "0"+seconds;}
  return hours+':'+minutes+':'+seconds;
}
