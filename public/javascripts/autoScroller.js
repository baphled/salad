(function($) {
// What does the autoScroller plugin do?
$.fn.autoScroller = function(options) {
  var opts = $.extend({}, $.fn.autoScroller.defaults, options);

  var width = $(this).parent().width();
  var $innerUnorderedList = $(this).find('ul');
  
  $innerUnorderedList.css('max-height', opts.height)
                     .css('overflow-y', 'hidden');

  $(this).parent().css('width', width);
  
  if ($(this).is(':visible')) {
    var stop = false;
    $innerUnorderedList.scrollTop(0);
    
    setInterval(function() {
      if (opts.stopOnHover) {
        $('div#sidebar > ul').live('mouseout mouseover', function(event) {
          stop = (event.type == 'mouseover')? true : false;
        });        
      };

      if (false == stop) {
        var previousOffset = $innerUnorderedList.scrollTop();

        $innerUnorderedList.scrollTop($innerUnorderedList.scrollTop() + 2);

        if ($innerUnorderedList.scrollTop() == previousOffset && 0 !== previousOffset) {
          $innerUnorderedList
            .animate({opacity: 0}, function() {
              $(this).scrollTop(0).animate({opacity: 1}, 300);
            });
        }
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