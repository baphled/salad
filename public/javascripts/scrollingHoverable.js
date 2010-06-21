(function($) {
/**
* Creates a scrolling hoverable item, which is displayed when hovered over.
*
* This element will then stay in position once and move along with the scrollbar, giving us a hover effect.
*
* @useage $('div').scrollingHoverable({scrollSpeed: 500, height: 500, stopOnHover: true})
*
* @author Yomi Colledge
**/
$.fn.scrollingHoverable = function(options) {
  var opts = $.extend({}, $.fn.scrollingHoverable.defaults, options);

  return $(this).live('mouseover', function() {
    var $sidebarList = $(opts.hoverListElement),
        sidebarPostfix = $('div#sidebar > ul').attr('id').split('_'),
        hoverItem = 'li#' + $(this).attr('id') + '_' + sidebarPostfix[1];

    $currentList = $(this).parent();
    $('ul.items-list li div').removeClass('highlighted');
    $currentList.addClass('highlighted');
    
    var setHoverPosition = function() {
      var y = $(window).scrollTop();
      
      if (y >= $('div#sidebar').offset().top) {
        $sidebarList.css('width', $('.hover').width())
                    .addClass('fixed');
      } else {
        $sidebarList.removeClass('fixed');
      }
    }
    
    $sidebarList.addClass('ui-widget ui-widget-content ui-corner-all');
    setHoverPosition();
    
    if (!$(hoverItem).is(':visible')) {
      $('div#sidebar').find('li.side_hover').hide();
      $sidebarList.find(hoverItem).toggle();
      $(hoverItem).autoScroller({speed: 200, height: opts.height, stopOnHover: opts.stopOnHover});

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
  height:250,
  hoverListElement: 'div#sidebar > ul',
  stopOnHover: false
};

})(jQuery);