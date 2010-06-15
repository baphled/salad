(function($) {
  /**
  * Toggles the panel icons display, using animation to display and hide the panel icons on a double click event
  *
  * @useage $('span.icons').animateIconPanel()
  *
  * @author Yomi Colledge
  **/
$.fn.animateIconPanel = function(options) {
  var opts = $.extend({}, $.fn.animateIconPanel.defaults, options);
  
  $(this).each(function() {
    var $iconList = $('ul.icons', this),
          $innerWrapper = $('<span>')
            .addClass('ui-icon ui-icon-info')
            .css({'float': 'left', 'padding-right': '0.3em'}),
          $innerContent = $('<strong>').append('Double click'),
          $content = $('<span> to view panel</span>'),
          $textWrapper = $('<span>')
            .append($innerWrapper)
            .append($innerContent)
            .append($content)
            .addClass(opts.panelTextClass)
            .css({'display': 'block', 'float': 'right'});

    $iconList.hide().parent().removeClass(opts.panelClass);
    $iconList.before($textWrapper);
  })

  $(this).unbind('dbclick');
  
  $(this).bind('dblclick', function(event) {
    var $iconsWrapper = $('ul', this),
        $openLink = $iconsWrapper.parent().find('>span'),
        $panel = $(this);

    // is list visible
    if ($iconsWrapper.is(':visible') == false) {
      $openLink.fadeOut(opts.speed, function() {
        $panel.addClass(opts.panelClass);
        $iconsWrapper.animate({opacity: 'toggle', height: 'toggle', width: 'toggle', background: opts.mouseoverBgColour}, 'slow');
      });
    } else {
      $iconsWrapper.animate({opacity: 'toggle', height: 'toggle', width: 'toggle', background: opts.mouseoutBgColour}, 'slow', function() {
      $panel.removeClass(opts.panelClass);
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
  speed:300,
  panelTextClass: 'view-panel ui-state-highlight',
  panelClass: 'icons ui-widget ui-widget-content ui-corner-all',
  mouseoutBgColour: '#89A407',
  mouseoverBgColour: '#fff'
};

})(jQuery);