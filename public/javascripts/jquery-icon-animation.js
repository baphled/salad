(function($) {
  /**
  * Toggles the panel icons display, using animation to display and hide the panel icons on a double click event
  *
  * The plugin relies on jQuery UI's layouts but can be easily customised to work with custom stylings
  *
  * @useage $('span.icons').animateIconPanel()
  *
  * @author Yomi Colledge
  **/
$.fn.animateIconPanel = function(options) {
  var opts = $.extend({}, $.fn.animateIconPanel.defaults, options);

  /**
  * Stop the propagation of our event on links
  *
  * @todo Make this more universal
  **/
  
   $("span#panel a, ul.icons a").each(function() {
     $(this).bind(opts.eventType, function(event) {
       event.stopPropagation();
     });
   });

  $(this).unbind(opts.eventType);
  
  /**
  * Bind our icon panel animation and stylings
  **/
  $(this).live(opts.eventType, function(event) {
    var $iconsWrapper = $('ul', this),
        $openLink = $iconsWrapper.parent().find('>span'),
        $panel = $(this);

    if ($iconsWrapper.is(':visible') == false) {
      $openLink.fadeOut(opts.speed, function() {
        $panel.addClass(opts.panelClass);
        $iconsWrapper.animate(panelAnimation(opts.mouseoverBgColour), opts.speed);
      });
    } else {
      $iconsWrapper.animate(panelAnimation(opts.mouseoutBgColour), opts.speed, function() {
        $panel.removeClass(opts.panelClass);
        $openLink.fadeIn();
      });
    }
    return false;
  });

  /**
  * Returns the stylings for our panel animation
  **/
  function panelAnimation(colour) {
    return {opacity: 'toggle', height: 'toggle', width: 'toggle', background: colour}
  }
  
  /**
  * Dynamically generate our icon panels
  *
  * @todo Allow for the the icon panels stylings are customisable
  **/
  return $(this).each(function() {
    var $iconList = $('ul.icons', this),
          $icon = $('<span>')
            .addClass('ui-icon ui-icon-info')
            .css({'float': 'left', 'padding-right': '0.3em'}),
          $innerContent = $('<strong>').append(opts.eventText),
          $content = $('<span>').append(' to view panel'),
          $textWrapper = $('<span>')
            .append($icon)
            .append($innerContent)
            .append($content)
            .addClass(opts.panelTextClass)
            .css({'display': 'block', 'float': 'right', 'cursor': 'pointer', 'padding': '4px'});

    $iconList.hide().parent().removeClass(opts.panelClass);
    $iconList.before($textWrapper);

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
  eventType: 'dblclick',
  eventText: 'Double click',
  panelTextClass: 'view-panel ui-state-highlight',
  panelClass: 'icons ui-widget ui-widget-content ui-corner-all',
  mouseoutBgColour: '#89A407',
  mouseoverBgColour: '#fff'
};

})(jQuery);