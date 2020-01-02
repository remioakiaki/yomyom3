$(document).on('click', "#clsbtn", function() {
  var val = $(this).attr("value");
  $('.comment_form_' + val ).slideUp();
  $('.btn-cls_' + val).hide();
  $('.btn-opn_' + val).css('display','inline') ;
});