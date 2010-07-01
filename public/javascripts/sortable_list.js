/*
 * Centralised sortable functionality used through out the site
 * 
 * @author Yomi Colledge
 *
 */
$(document).ready(function() {
  // Toggle our position handler
  $('.order_icon').live("click",function() {
      $('#lists').toggleClass('active');
      $(this).toggleClass('active');
      $('.handler').toggle();
  });

  $.fn.customSortable = function() {
    // if no handlers are rendered we don't need an order button
    if ($('span.handler').size() > 1) {
      $button = $("<button>")
        .append('Order')
        .addClass('order_icon ui-state-default ui-priority-primary ui-corner-all')
        .attr('id', 'button')
        .attr('role', 'button');

      $('div#list-head').prepend($button);
    };
    
    $(this).sortable({
      axis:'y',
      dropOnEmpty:false,
      handle:'.handler',
      cursor: 'crosshair',
      items: 'li',

      update:function(){
        $.ajax({
          data:$(this).sortable('serialize'),
          dataType:'script',
          type:'post',
          url: "/" + $(this).attr('id') + "/sort"})
      }
    });
  }
});