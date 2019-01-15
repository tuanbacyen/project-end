$(document).ready(function () {
  $(".tbtn").click(function () {
    if($(this).find('i').hasClass('fa-plus-circle') == true) {
      $(this).find('i').removeClass('fa-plus-circle');
      $(this).find('i').addClass('fa-minus-circle');
      $(this).parents("tbody").find(".toggler").addClass("toggler1");
    } else {
      $(this).find('i').removeClass('fa-minus-circle');
      $(this).find('i').addClass('fa-plus-circle');
      $(this).parents("tbody").find(".toggler1").removeClass("toggler1");
    }
  });
});
