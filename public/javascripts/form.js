$(document).ready(function() {

  $('form').submit(function() {
    var postData = $(this).serialize();
    $.post($(this).attr('action'), postData, null, "script");
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

  $('fieldset.inputs > ol li').generateFormatasticTooltips();
});