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
      stop = false,
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
    previousOffset = null;
    $innerUnorderedList.scrollTop(0);
    
    $("#item-list-top").remove();
    $("#item-list-bottom").remove();
    if (parseInt($(this).height()) >= 250) {
      $(' hr:first', this).before("<div id=item-list-top />");
      $('hr:last', this).before("<div id=item-list-bottom />");
      $('body').mouseout(function() {stop = true;}).mouseover(function() {stop = false;});
    }
    
    var scrollerId = setInterval(function() {
      if (false == stop) {
        if ($innerUnorderedList.scrollTop() == parseInt($(this).height())) {
          $innerUnorderedList.animate({scrollTop: 0}, 'slow');
          previousOffset = null;
        } else {
          $innerUnorderedList.animate({scrollTop: $innerUnorderedList.scrollTop() + 1}, 5);
        }

        previousOffset = $innerUnorderedList.scrollTop();
  
      }
    }, opts.speed);
    
  } else {
    clearInterval(scrollerId);
    console.log('cleared');
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