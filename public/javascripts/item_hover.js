$(document).ready(function() {
  
  var hoverItem = function() {
    $sidebarPostfix = $('div#sidebar > ul').attr('id').split('_');

    $hover_class = 'li#' + $(this).attr('id') + '_' + $sidebarPostfix[1];
    $($hover_class).toggle();
  };
  
  $("div.list_item").live('mouseover mouseout', hoverItem);
});