$( document ).ready(function() {
  setTimeout(change_btn, 3000);
});

function change_btn() {
  $('#btntest').html('<i class="fa fa-quote-left fa-4x text-muted pull-left"></i>');
}
