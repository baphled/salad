/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
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