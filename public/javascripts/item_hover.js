$(document).ready(function() {

  $.fn.autoScroller = function(speed,height) {
    var width = $(this).parent().width();
    var $innerUnorderedList = $(this).find('ul');
    
    $innerUnorderedList.css('max-height', height)
                       .css('overflow-y', 'hidden');

    $(this).parent().css('width', width);
    
    if ($(this).is(':visible')) {
      var stop = false;
      $innerUnorderedList.scrollTop(0);
      
      setInterval(function() {
        $('div#sidebar > ul').live('mouseout mouseover', function(event) {
          stop = (event.type == 'mouseover')? true : false;
        });

        if (false == stop) {
          var previousOffset = $innerUnorderedList.scrollTop();

          $innerUnorderedList.scrollTop($innerUnorderedList.scrollTop() + 2);

          if ($innerUnorderedList.scrollTop() == previousOffset && 0 !== previousOffset) {
            // here we should pad the start and end with the first and last 3 items respective
            // can find a similar solution to this @ http://apple.com
            $innerUnorderedList.scrollTop(0);
          }
        }
      }, speed);
    }
  }

  $.fn.scrollingHoverable = function() {
    $(this).live('mouseover', function() {
      var sidebarPostfix = $('div#sidebar > ul').attr('id').split('_');
      var $sidebar = $('div#sidebar > ul');
      var hoverItem = 'li#' + $(this).attr('id') + '_' + sidebarPostfix[1];
      var height = $('div#lists').outerHeight() - $('div#footer').outerHeight();

      $sidebar.addClass('ui-widget ui-widget-content ui-corner-all fixed');

      if (!$(hoverItem).is(':visible')) {
        $('div#sidebar').find('li.side_hover').hide();
        $sidebar.find(hoverItem).toggle();
        $(hoverItem).autoScroller(500, height);

        $(window).scroll(function() {
          var y = $(window).scrollTop();

          if (y >= $('div#sidebar').offset().top) {
            $sidebar.css('width', $('.hover').width())
            $sidebar.addClass('fixed');
          } else {
            $(hoverItem).find('ul').css('');
            $sidebar.removeClass('fixed');
          }
        });
      }
    });
  };

  $("div.list_item").scrollingHoverable();
});