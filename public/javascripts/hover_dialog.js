// Functionality to create hover dialog boxes for our tag input
$(document).ready(function() {
  
  // Create acessors for our hover dialog
  var $formAction = $('form').attr('action'),
      formIdArray = $('form').attr('id').split('_');
      resourceSingular = formIdArray[1],
      resourcePlural = resourceSingular.pluralize(),
      $tagInput = $('input#'+ resourceSingular + '_tag_list'),
      $tagInputWrapper = $('li#'+ resourceSingular + '_tag_list_input'),
      $hoverDialog = $("<div></div>")
      .addClass('hover ui-widget ui-widget-content ui-corner-all')
      .insertAfter($tagInput)
      .hide();

  $tagInput.focus(function() {
    $url = '/' + resourcePlural + "/tags.json";
    $.ajax({
      url: $url,
      data: $tagInput.serialize(),
      dataType: 'json',
      type: 'GET',
      success: function(data) {
    		if (data.length && $hoverDialog.empty()) {
    			$.each(data, $enableHoverLink);
    		}
    	}
    });
  });
  
  var $enableHoverLink = function(index, item) {
	  var tags = $tagInput.val().split(', '),
	      result = $.inArray(item['tag']['name'], tags);

	  if (result == -1) {
		  $hoverDialog
		    .append($('<a href="javascript:///>"')
		    .append(item['tag']['name'])
		    .addClass('hover_select')
		    .attr('id','item_' + item['tag']['id'])
		    .click(function() {
		      var content = '';
		      // Add comma if there is already a tag in the input field
		      if ($tagInput.attr('value') != '') {
		        content = $tagInput.attr('value') + ', ';
		      };
		      content += ($tagInput.attr('value') == '')? $(this).html() : $(this).html();

		      $tagInput.attr('value', content);
		      $(this).fadeOut().remove();
		      
		      // if there are no more tags we should hide the dialog panel
		      if ($hoverDialog.html() == '  ') {
		        $hoverDialog.fadeOut().remove();
		      }
          return false;
        })
      ).append(' ').fadeIn();
	  };
	};
});