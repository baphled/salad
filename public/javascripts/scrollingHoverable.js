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
    var sidebarPostfix = $('div#sidebar > ul').attr('id').split('_');
    var $sidebarList = $('div#sidebar > ul');
    var hoverItem = 'li#' + $(this).attr('id') + '_' + sidebarPostfix[1];
    
    var headerHeight = $(hoverItem).find('h3').outerHeight(),
        footerHeight = $('div#footer').outerHeight(),
        listHeight = $('div#lists').outerHeight();
    
    var height = (listHeight - footerHeight * 2);
    var setHoverPosition = function() {
      var y = $(window).scrollTop();
      
      if (y >= $('div#sidebar').offset().top) {
        $sidebarList.css('width', $('.hover').width())
        $sidebarList.addClass('fixed');
      } else {
        // $(hoverItem).find('ul').css('');
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
  stopOnHover: false
};

})(jQuery);