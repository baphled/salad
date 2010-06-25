(function($) {
/**
* A simple flash message render used for when we return an AJAX response
* @todo Add optional animation functionality
**/
$.fn.renderFlashMessage = function(options) {
  var opts = $.extend({}, $.fn.renderFlashMessage.defaults, options);

  return this.each(function() {
    var $this = $(this),
        $flashDiv = $("<div>").addClass("flash"),
        $flashNoticeDiv = $("<div>").addClass("notice").html(opts.flashMessage);
        
    $this.before($flashDiv.html($flashNoticeDiv));
  });

  // private function for debugging
  function debug($obj) {
    if (window.console && window.console.log) {
      window.console.log($obj);
    }
  }
};

// default options
$.fn.renderFlashMessage.defaults = {
  flashMessage: 'Default flash message'
};

})(jQuery);