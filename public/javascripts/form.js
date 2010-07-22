$(document).ready(function() {

  $('form').hoverDialog();
  
  $('form').live('submit', function() {
    var postData = $(this).serialize(),
        $form = $(this).clone();

    $('button', this).button('disable');
    if ($form.hasClass('hidden') == false) {
      // Convert our content-wide id to content, to allow us to render the side bar
      var $content = $('div#container').find('div#content-wide');
      $content.attr('id', 'content');
      $("<div id='sidebar'></div>").insertAfter($content);
  
      // Setup of info container used to render our items information
      var projectInfo = $("<div></div>").attr('id','info');
      $('#wrapper').html($(projectInfo));
    
    }

    $.post($(this).attr('action'), postData, function(data) {
      var files = [
          '/javascripts/autoScroller.js',
          '/javascripts/scrollingHoverable.js',
          '/javascripts/sortable_list.js',
          '/javascripts/pagination.js'
      ];

      $.include(files, function() {
        if ($form.hasClass('hidden') == false) {
          // here is where we make our necessary form response for all our AJAX based responses
          $('#wrapper').append($form.hide());
          $('<button class="display_form button" href="javascript://">view form</a>')
            .insertBefore('#wrapper form')
            .button({ option: 'text' });
        }
        // setup our generic list events
        $('ul.icons li .handler').button('option', 'icon');
        $('ul.icons li, button.button').button({ option: 'text' });
        $('span#panel, ul.items-list li > span').animateIconPanel({eventType: 'click', eventText: 'Click'});
        $('div#lists ul').customSortable();

        $('form').hoverDialog();
        if ($('div=sidebar >ul').size() >= 1) {
          $("div.list_item").scrollingHoverable({stopOnHover: true});
        }
        $('a[title]').tipsy({fade: true});
      });
      
    }, "script");
    return false;
  });

  $("button.display_form").live("click",function() {
    var $link = $(this),
        title_array = $link.text().split(' '),
        prefix = '';

    $('form').toggle(function() {
      prefix = ('view' == title_array[0])? 'hide ' : 'view ';
      $link.button({ option: 'text' , label: prefix + title_array[1]});
    });
  });

  // Disable autocomplete for our imput elements
  $('input').attr('autocomplete','off');
  $('fieldset.views').hide();
  $('fieldset.inputs > ol li').generateFormatasticTooltips();
});