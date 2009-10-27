$(document).ready(function() {
  
  var $resource = 'project'
  var $tagInput = $('input#'+ $resource + '_tag_list');
  
  var $hoverDialog = $("<div></div>")
      .addClass('hover')
      .addClass('ui-widget')
      .addClass('ui-widget-content')
      .addClass('ui-corner-all')
      .insertAfter($tagInput)
      .hide();
      
  var $hoverSelect = $('<li></li>').addClass('hover_select');

  $tagInput.focus(function() {
    $('.hover').fadeIn();
    $.ajax({
    	'url': "/projects/tags.json",
    	'dataType': 'json',
    	'type': 'GET',
    	'success': function(data) {
    		if (data.length) {
    		  $hoverDialog.empty();
    			$.each(data, function(index, item) {
    			  $hoverDialog.append($('<a href="javascript:///>"')
    			    .append(item['tag']['name'])
    			    .addClass('hover_select')
    			    .attr('id','item_' + item['tag']['id'])
    			    .click(function() {
    			      $tagInput.attr('value',$tagInput.attr('value') + $(this).html() + ', ');
    			      $(this).fadeOut();
                return false;
              }))
    			    .append(' ');
    			});
    		}
    	}
    });    
  });
});