$(document).ready(function() {

  $('form').submit(function() {
    var postData = $(this).serialize();
    $.post($(this).attr('action'), postData, function(data) {
      // here is where we make our necessary form response for all our AJAX based responses
      
      $('ul.items-list li > span').animateIconPanel({eventType: 'click', eventText: 'Click'});
      $('a[title]').tipsy({fade: true});
    }, "script");
    return false;
  });

  $("a.display_form").live("click",function(event) {
    var link = $(this);
    var id_attribute_name = link.attr('id').split('_');
    var title_array = link.text().split(' ');

    $('form').toggle(function() {
      if('view' == link.text().substr(0,4)) {
        link.text('hide ' + title_array[1]);
      } else {
        link.text('view ' + title_array[1]);
      }
    });
  });

  // Disable autocomplete for our imput elements
  $('input').attr('autocomplete','off');
  
  $('fieldset.inputs > ol li').generateFormatasticTooltips();
});