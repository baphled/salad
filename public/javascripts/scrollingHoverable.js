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
        sidebarPostfix = $sidebarList.attr('id').split('_'),
        hoverItem = 'li#' + $(this).attr('id') + '_' + sidebarPostfix[1],
        headerHeight = $(hoverItem).find('h3').outerHeight(),   // Hover title element
        footerHeight = $('div#footer').outerHeight(),   // footer element
        listHeight = $('div#lists').height(),     // main contents height
        height = (listHeight - (footerHeight * 3) - headerHeight),
        y = $(window).scrollTop();
        
    var setHoverPosition = function() {
      if (y >= $sidebarList.offset().top) {
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
      $(hoverItem).autoScroller({speed: 200, height: height, stopOnHover: opts.stopOnHover});

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
  height:500,
  hoverListElement: 'div#sidebar > ul',
  stopOnHover: false
};

})(jQuery);