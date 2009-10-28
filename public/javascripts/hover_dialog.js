$(document).ready(function() {
  
  var $formAction = $('form').attr('action');
  var $formID = $('form').attr('id');
  
  var $resourceSingular = $formID.substring(4,$formID.length);
  var $resourcePlural = $formAction.substring(1,$formAction.length);
  
  var $tagInput = $('input#'+ $resourceSingular + '_tag_list');
  
  var $hoverDialog = $("<div></div>")
      .addClass('hover')
      .addClass('ui-widget')
      .addClass('ui-widget-content')
      .addClass('ui-corner-all')
      .insertAfter($tagInput)
      .hide();
      
  var $hoverSelect = $('<li></li>').addClass('hover_select');

  $tagInput.focus(function() {
    $url = '/' + $resourcePlural + "/tags.json";
    $.ajax({
    	'url': $url,
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
    $('.hover').fadeIn();
  });
});