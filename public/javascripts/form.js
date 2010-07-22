$(document).ready(function() {
  var method = 'POST';
  
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

    if (window.location.pathname.indexOf('edit') != -1) {
      method = 'PUT';
    }
    
    $.ajax({
        'url': $(this).attr('action'),
        'data': postData,
        'type': method,
        'success': function(data) {
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
              $('<button class="display_form button">view form</button>')
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
          
          $("button.display_form").live("click",function() {
            var $link = $(this),
                title_array = $link.text().split(' '),
                prefix = '';

            $('form').toggle(function() {
              prefix = ('view' == title_array[0])? 'hide ' : 'view ';
              $link.button({ option: 'text' , label: prefix + title_array[1]});
            });
          });


          return false;
        }
    });
  });
  // Disable autocomplete for our imput elements
  $('input').attr('autocomplete','off');
  $('fieldset.views').hide();
  $('fieldset.inputs > ol li').generateFormatasticTooltips();
});