// Functionality to create hover dialog boxes for our tag input
$(document).ready(function() {
  
  // Create acessors for our hover dialog
  var $formAction = $('form').attr('action');
  var $formID = $('form').attr('id');
  
  // We need singular & plural resource names to take advantage of hover dialog
  var formIdArray = $formID.split('_');
  var $resourceSingular = formIdArray[1];
  var $resourcePlural = formIdArray[1] + 's';
  
  // Selector for our tag input
  var $tagInput = $('input#'+ $resourceSingular + '_tag_list');
  var $tagInputWrapper = $('li#'+ $resourceSingular + '_tag_list_input');
  
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
        'data': $tagInput.serialize(),
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

  $tagInputWrapper.blur(function() {
    $('.hover').fadeOut();
  });
});