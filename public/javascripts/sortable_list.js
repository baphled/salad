/*
 * Centralised sortable functionality used through out the site
 * 
 * @author Yomi Colledge
 *
 */
$(document).ready(function() {
  // Dynamically style our list
  $('#lists, .order_icon, .icons').addClass('ui-widget ui-widget-content ui-corner-all');

  // Toggle our position handler
  $('span.order_icon').live("click",function() {
      $('#lists').toggleClass('active');
      $('.handler').toggle();
  });

  $.fn.customSortable = function() {
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

  // sort our list
  $('div#lists ul').customSortable();
});