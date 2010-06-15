(function($) {
  /**
  * Plugin to help determine the position of a given element, making sure that it is always at the top of the page.
  *
  * @useage $('div ul').autoScroller({scrollSpeed: 500, height: 500, stopOnHover: true})
  *
  * @author Yomi Colledge
  **/
$.fn.animateIconPanel = function(options) {
  var opts = $.extend({}, $.fn.autoScroller.defaults, options);
  
  $(this).each(function() {
    var $iconList = $('ul.icons', this),
          $innerWrapper = $('<span>')
            .addClass('ui-icon ui-icon-info')
            .css({'float': 'left', 'margin-right': '0.3em'}),
          $innerContent = $('<strong class="dbl-click">Double click</strong>')
            .append(' to view panel'),
          $textWrapper = $('<span>')
            .append($innerWrapper)
            .append($innerContent)
            .addClass('view-panel ui-state-highlight')
            .css({'display': 'block', 'float': 'right'});

    $iconList.hide().parent().removeClass('icons ui-widget ui-widget-content ui-corner-all');
    $iconList.before($textWrapper);
  })

  $(this).unbind('dbclick');
  
  $(this).bind('dblclick', function(event) {
    var $iconsWrapper = $('ul', this),
        $openLink = $iconsWrapper.parent().find('>span'),
        $panel = $(this);

    // is list visible
    if ($iconsWrapper.is(':visible') == false) {
      $openLink.fadeOut(300, function() {
        $panel.addClass('icons ui-widget ui-widget-content ui-corner-all');
        $iconsWrapper.animate({opacity: 'toggle', height: 'toggle', width: 'toggle', background: '#fff'}, 'slow');
      });
    } else {
      $iconsWrapper.animate({opacity: 'toggle', height: 'toggle', width: 'toggle', background: '#89A407'}, 'slow', function() {
      $panel.removeClass('icons ui-widget ui-widget-content ui-corner-all');
        $openLink.fadeIn();
      });
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
$.fn.animateIconPanel.defaults = {
  speed:500
};

})(jQuery);