/*
 * Centralised sortable functionality used through out the site
 * 
 * @author Yomi Colledge
 *
 */
$(document).ready(function() {
  $('div#lists ul').sortable({
    axis:'y',
    dropOnEmpty:false,
    handle:'.order_box',
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
});