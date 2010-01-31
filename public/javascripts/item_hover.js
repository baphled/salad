$(document).ready(function() {
  $("div.list_item").each(function(event) {

    $(this).mouseover(function() {
      $classArray = $(this).attr('class').replace(' ','_').split(' ');
      $hover_class = 'li.' + $classArray[1];
      $($hover_class).toggle();
    });

    $(this).mouseout(function() {
      $classArray = $(this).attr('class').replace(' ','_').split(' ');
      $hover_class = 'li.' + $classArray[1];
      $($hover_class).toggle();
    });
  });
});