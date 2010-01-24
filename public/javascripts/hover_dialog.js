// Functionality to create hover dialog boxes for our tag input
$(document).ready(function() {
  
  // Create acessors for our hover dialog
  var $formAction = $('form').attr('action');
  var $formID = $('form').attr('id');
  
  // We need singular & plural resource names to take advantage of hover dialog
  var $resourceSingular = $formID.substring(4,$formID.length);
  var $resourcePlural = $formAction.substring(1,$formAction.length);
  
  // Selector for our tag input
  var $tagInput = $('input#'+ $resourceSingular + '_tag_list');
  
  // The hover dialog we'll use to populate our tags
  var $hoverDialog = $("<div></div>")
      .addClass('hover')
      .addClass('ui-widget')
      .addClass('ui-widget-content')
      .addClass('ui-corner-all')
      .insertAfter($tagInput)
      .hide();

  $tagInput.focus(function() {
    $url = '/' + $resourcePlural + "/tags.json";
    $.ajax({
    	'url': $url,
    	'dataType': 'json',
    	'type': 'GET',
    	'success': function(data) {
    		if (data.length) {
    		  if($hoverDialog.empty()) {
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
    	}
    });    
    $('.hover').fadeIn();
  });
});