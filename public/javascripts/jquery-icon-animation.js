$(function() {
  // icon animation
  var $iconList = $('span.icons >ul');

  $iconList.hide().parent().removeClass('icons ui-widget ui-widget-content ui-corner-all');
  $iconList.before('<span class="view-panel">Double click to view panel</span>');
  $('span.view-panel').css({'display': 'block', 'float': 'right'});

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
      });
      $openLink.show();
    }
  });

})