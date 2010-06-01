$(document).ready(function() {

  $.fn.autoScroller = function(speed,height) {
    var $innerUnorderedList = $(this).find('ul');
    console.log($innerUnorderedList);
    $innerUnorderedList.css('height', height)
                       .css('overflow-y', 'auto');

    $innerUnorderedList.scrollTop(0);
    var scrollList = setInterval(function() {
      var previousOffset = $innerUnorderedList.scrollTop();

      $innerUnorderedList.scrollTop($innerUnorderedList.scrollTop() + 2);

      if ($innerUnorderedList.scrollTop() == previousOffset) {
        $innerUnorderedList.scrollTop(0);
      }
    }, speed);
  }
  
  var $hoverItem = function() {
    var sidebarPostfix = $('div#sidebar > ul').attr('id').split('_');
    var $sidebar = $('div#sidebar > ul');
    var item = 'li#' + $(this).attr('id') + '_' + sidebarPostfix[1];
    var height = $('div#content').height();

    height = height - ($('div#footer').height() * 2);
    
    $sidebar.find(item).toggle();

    // Sets the hover item to a fixed position when the cursor is moved
    $(window).scroll(function() {
      var y = $(window).scrollTop();
      if (y >= $('div#sidebar').offset().top) {      
        $sidebar.addClass('fixed');
        $(item).autoScroller(500, height);
      } else {
        $(item).css('').find('ul').css('');
        $sidebar.removeClass('fixed');
      }
    });

  };
  
  $("div.list_item").live('mouseover mouseout', $hoverItem);
});