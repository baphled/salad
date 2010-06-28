(function($) {
  /**
  * Plugin to help determine the position of a given element, making sure that it is always at the top of the page.
  *
  * @useage $('div ul').autoScroller({scrollSpeed: 500, height: 500, stopOnHover: true})
  *
  * @author Yomi Colledge
  **/
$.fn.hoverDialog = function(options) {
  var opts = $.extend({}, $.fn.hoverDialog.defaults, options);

  // Create acessors for our hover dialog
  var formIdArray = $(this).attr('id').split('_');
      resourceSingular = formIdArray[1],
      resourcePlural = resourceSingular.pluralize(),
      $tagInput = $('input#'+ resourceSingular + '_tag_list'),
      $tagInputWrapper = $('li#'+ resourceSingular + '_tag_list_input'),
      $hoverDialog = $("<div></div>")
        .addClass('hover ui-widget ui-widget-content ui-corner-all')
        .insertAfter($tagInput)
        .hide();

  $tagInput.focusout(function() {
    $hoverDialog.fadeOut();
  });

  $tagInput.focus(function() {
    var url = '/' + resourcePlural + "/tags.json";
    $.ajax({
      url: url,
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
            // @todo cleanup as this could be done cleaner
            if ($hoverDialog.html() == (' ' || '')) {
              $hoverDialog.fadeOut();
            }
        return false;
      })
    ).append(' ').fadeIn();
    }
  };
  // private function for debugging
  function debug($obj) {
    if (window.console && window.console.log) {
      window.console.log($obj);
    }
  }
};

// default options
$.fn.hoverDialog.defaults = {
  stopOnHover: false
};

})(jQuery);