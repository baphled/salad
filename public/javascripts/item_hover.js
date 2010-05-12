$(document).ready(function() {
  
  var hoverItem = function() {
    $classArray = $(this).attr('id');
    $sidebarPostfix = $('div#sidebar > ul').attr('id').split('_');
    
    $hover_class = 'li#' + $classArray + '_' + $sidebarPostfix[1];
    $($hover_class).toggle();
  };
  
  $("div.list_item").each(function(event) {
    $(this).mouseover(hoverItem);
    $(this).mouseout(hoverItem);
  });
});