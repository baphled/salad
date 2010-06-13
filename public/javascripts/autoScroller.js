(function($) {
  /**
  * Plugin to help determine the position of a given element, making sure that it is always at the top of the page.
  *
  * @useage $('div ul').autoScroller({scrollSpeed: 500, height: 500, stopOnHover: true})
  *
  * @author Yomi Colledge
  **/
$.fn.autoScroller = function(options) {
  var opts = $.extend({}, $.fn.autoScroller.defaults, options);
  var width = $(this).parent().width(),
      $innerUnorderedList = $(this).find('ul'),
      previousOffset = null;

  $innerUnorderedList.css('max-height', opts.height)
                     .css('overflow-y', 'hidden');

  $(this).parent().css('width', width);

  if (opts.stopOnHover) {
    $('div#sidebar > ul').live('mouseout mouseover', function(event) {
      stop = (event.type == 'mouseover')? true : false;
    });
  }

  if ($(this).is(':visible')) {
    var stop = false,
        $unorderedList = $('ul.hover li:visible > hr:first');

    $innerUnorderedList.scrollTop(0);

//    $unorderedList.before($("<div id='list-item-top'>"));
    setInterval(function() {

      if (false == stop) {
        $innerUnorderedList.scrollTop($innerUnorderedList.scrollTop() + 1);

        if ($innerUnorderedList.scrollTop() == previousOffset && 0 !== previousOffset) {
          $innerUnorderedList
            .animate({scrollTop: 0}, opts.speed / 2);
        }


        $('body').mouseout(function() { stop = true; }).mouseover(function() { stop = false; });
        
        if ((previousOffset && $innerUnorderedList.scrollTop()) == 0) {
          stop = false;
        }
        
        previousOffset = $innerUnorderedList.scrollTop();
      }
    }, opts.speed);
  }

  // private function for debugging
  function debug($obj) {
    if (window.console && window.console.log) {
      window.console.log($obj);
    }
  }
};

// default options
$.fn.autoScroller.defaults = {
  speed:500,
  height:200,
  stopOnHover: false
};

})(jQuery);