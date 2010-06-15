$(function() {
  // icon animation
  var $iconList = $('span.icons >ul'),
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

  $('span#panel, ul.items-list li > span').live('dblclick', function(event) {
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

})