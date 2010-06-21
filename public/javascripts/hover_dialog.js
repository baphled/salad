// Functionality to create hover dialog boxes for our tag input
$(document).ready(function() {
  
  // Create acessors for our hover dialog
  var $formAction = $('form').attr('action'),
      $formID = $('form').attr('id'),
      formIdArray = $formID.split('_');
      resourceSingular = formIdArray[1],
      resourcePlural = resourceSingular.pluralize(),
      $tagInput = $('input#'+ resourceSingular + '_tag_list'),
      $tagInputWrapper = $('li#'+ resourceSingular + '_tag_list_input'),
      $hoverDialog = $("<div></div>")
      .addClass('hover ui-widget ui-widget ui-corner-all')
      .insertAfter($tagInput)
      .hide();

  $tagInput.focus(function() {
    $url = '/' + resourcePlural + "/tags.json";
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
        })
      ).append(' ').fadeIn();
	  };
	};
});