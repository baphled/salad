$(document).ready(function() {

  $.fn.autoScroller = function(speed,height) {
    var width = $(this).parent().width();
    var $innerUnorderedList = $(this).find('ul');
    $innerUnorderedList.css('max-height', height)
                       .css('overflow-y', 'hidden');

    $(this).parent().css('width', width);
    
    if ($(this).is(':visible')) {
      $innerUnorderedList.scrollTop(0);
      
      setInterval(function() {
        var previousOffset = $innerUnorderedList.scrollTop();

        $innerUnorderedList.scrollTop($innerUnorderedList.scrollTop() + 2);

        if ($innerUnorderedList.scrollTop() == previousOffset) {
          $innerUnorderedList.scrollTop(0);
        }
      }, speed);
    }
  }
  
  var hoverItem = function() {
    var sidebarPostfix = $('div#sidebar > ul').attr('id').split('_');
    var $sidebar = $('div#sidebar > ul');
    var hoverItem = 'li#' + $(this).attr('id') + '_' + sidebarPostfix[1];
    var height = $('div#lists').outerHeight() - $('div#footer').outerHeight();

    if (!$(hoverItem).is(':visible')) {
      $('div#sidebar').find('li.side_hover').hide();
      $sidebar.find(hoverItem).toggle();
      $(hoverItem).autoScroller(500, height);
      // Sets the hover item to a fixed position when the cursor is moved
      $(window).scroll(function() {
        var y = $(window).scrollTop();
        if (y >= $('div#sidebar').offset().top) {
          $sidebar.addClass('fixed');
        } else {
          $(hoverItem).find('ul').css('');
          $sidebar.removeClass('fixed');
        }
      });
    }

  };
  
  $("div.list_item").live('mouseover', hoverItem);
});