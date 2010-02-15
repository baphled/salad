$(document).ready(function() {
  $('form').submit(function() {
    var postData = $(this).serialize();
    $.post($(this).attr('action'), postData, null, "script");
    return false;
  });

});