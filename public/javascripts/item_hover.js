$(document).ready(function() {
  
  var $hoverItem = function() {
    var sidebarPostfix = $('div#sidebar > ul').attr('id').split('_');
    var $sidebar = $('div#sidebar > ul');
    
    var item = 'li#' + $(this).attr('id') + '_' + sidebarPostfix[1];
    
    $sidebar.find(item).toggle();
  };
  
  $("div.list_item").live('mouseover mouseout', $hoverItem);
});