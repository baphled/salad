// Functionality to create hover dialog boxes for our tag input
$(document).ready(function() {
  
  // Create acessors for our hover dialog
  var $formAction = $('form').attr('action');
  var $formID = $('form').attr('id');
  
  // We need singular & plural resource names to take advantage of hover dialog
  var formIdArray = $formID.split('_');
  var $resourceSingular = formIdArray[1];
  var $resourcePlural = '';
  
  // Should really use some kind of pluralisation technique
  if ($resourceSingular == 'story') {
    $resourcePlural = 'stories'
  } else {
    $resourcePlural = $resourceSingular + 's';
  };
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
      			$.each(data, $enableHoverLink);
    		  }
    		}
    	}
    });
  });

  $tagInputWrapper.blur(function() {
    $('.hover').fadeOut();
  });
  
  var $enableHoverLink = function(index, item) {
	  var tags = $tagInput.val().split(',');
	  var result = $.inArray(item['tag']['name'], tags);
	  if (result == -1) {
		  $hoverDialog.append($('<a href="javascript:///>"')
		    .append(item['tag']['name'])
		    .addClass('hover_select')
		    .attr('id','item_' + item['tag']['id'])
		    .click(function() {
		      $tagInput.attr('value',$tagInput.attr('value') + $(this).html() + ', ');
		      $(this).fadeOut();
          return false;
        }))
		    .append(' ')
		    .fadeIn();
	  };
	};
});