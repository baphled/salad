// This sets up the proper header for rails to understand the request type,
// and therefore properly respond to js requests (via respond_to block, for example)
$.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$(document).ready(function() {
  /**
  * Plugin variable
  **/
  var accOpts = {
        event: "click",
        autoHeight: false,
        fillSpace: false,
        navigation: true
      },
      animateIconOpts = {
        eventType: 'click',
        eventText: 'Click'
      };
  

  /**
   * Handling the viewing and hiding of our item checkboxes
   */
  $("a.display_info").live("click", function(event) {
    var checkbox_link = $(this);
    var id_attribute_name = checkbox_link.attr('id').split('_');
    var title_array = checkbox_link.text().split(' ');

    $('fieldset.views#fieldset_' + id_attribute_name[0]).toggle(function() {
      if('view' == checkbox_link.text().substr(0,4)) {
        checkbox_link.text('hide ' + title_array[1]);
      } else {
        checkbox_link.text('view ' + title_array[1]);
      }
    });
  });

  // UJS authenticity token fix: add the authenticy_token parameter
  // expected by any Rails POST request.
  $(document).ajaxSend(function(event, request, settings) {
    // do nothing if this is a GET request. Rails doesn't need
    // the authenticity token, and IE converts the request method
    // to POST, just because - with love from redmond.
    if (settings.type == 'GET') return;
    if (typeof(AUTH_TOKEN) == "undefined") return;
    settings.data = settings.data || "";
    settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
  });
  
  // Plugin intialisation
  $('#myTabs').tabs();
  $('ul.accordion').accordion(accOpts);
  // @todo Refactor initalisation so that they are enabled regardless of the current DOM

  function instantiateOrderedListEvents() {
    if ($('div#lists ul').size()) {
      $('div#lists ul').customSortable();
    }
    $('ul.icons li, button.button').button({option: 'text'});
    $('span#panel, ul.items-list li > span').animateIconPanel(animateIconOpts);
    $('li[title], button[title]').tipsy({fade: true});
  }

  instantiateOrderedListEvents();

  var $originalSteps = null;

  var displayExamples = function(event) {

    var $headings = $('table.ui-tabs:visible > thead tr:last td b'),   // get headings
        $currentRow = $('td', this),
        $steps = $('ul.steps:visible li').egrep(/<(\w+)>/i);           // get steps with <>'s

    if (event.type == 'mouseenter') {
      $originalSteps = $('ul.steps:visible li').clone();
    }

    // search through each of the headings
    $currentRow.each(function() {
      var $row = $(this);
      var found = false;

      $headings.each(function(){
        var $heading = $(this),
            matcher = '<' + $heading.text() + '>';
        // search and replace matcher with the steps value
        if (found == false) {
          $steps.each(function() {
            var $step = $(this);
            // if the step contains the matcher
            var re = new RegExp(matcher);
            if (re.exec($step.text())) {
              var newString = $step.text().replace(matcher, $row.text());
              // replace text
              $step.text(newString);
              // return found
              found = true;
            }
          });
        }
      });
    });
  };

  var restoreExamples = function() {
    // revert
    $('ul.steps:visible li').replaceWith($originalSteps);
  }
  
  $('table.ui-tabs tbody tr').hover(displayExamples, restoreExamples);
});