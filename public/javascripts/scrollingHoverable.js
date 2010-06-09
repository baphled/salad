(function($) {
// What does the scrollingHoverable plugin do?
$.fn.scrollingHoverable = function(options) {
  var opts = $.extend({}, $.fn.scrollingHoverable.defaults, options);

  $(this).live('mouseover', function() {
    var sidebarPostfix = $('div#sidebar > ul').attr('id').split('_');
    var $sidebar = $('div#sidebar > ul');
    var hoverItem = 'li#' + $(this).attr('id') + '_' + sidebarPostfix[1];
    var height = $('div#lists').outerHeight() - $('div#footer').outerHeight();
    
    var setHoverPosition = function() {
      var y = $(window).scrollTop();
      
      if (y >= $('div#sidebar').offset().top) {
        $sidebar.css('width', $('.hover').width())
        $sidebar.addClass('fixed');
      } else {
        $(hoverItem).find('ul').css('');
        $sidebar.removeClass('fixed');
      }
    }
    
    $sidebar.addClass('ui-widget ui-widget-content ui-corner-all');
    setHoverPosition();
    
    if (!$(hoverItem).is(':visible')) {
      $('div#sidebar').find('li.side_hover').hide();
      $sidebar.find(hoverItem).toggle();
      $(hoverItem).autoScroller({speed: 500, height: height});

      $(window).scroll(setHoverPosition);
    }
  });

  // private function for debugging
  function debug($obj) {
    if (window.console && window.console.log) {
      window.console.log($obj);
    }
  }
};

// default options
$.fn.scrollingHoverable.defaults = {
  scrollSpeed:500,
  height:500
};

})(jQuery);