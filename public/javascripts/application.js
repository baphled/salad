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
  
  //hover states on the static widgets
  $('ul.icons li, button, span.handler').live('mouseover mouseout', function(event) {
    (event.type == 'mouseover')? $(this).addClass('ui-state-hover') : $(this).removeClass('ui-state-hover');
  });
  /**
   * We don't want our checkboxes viewable initially
   */
  $('.views').hide();

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
  $('span#panel, ul.items-list li > span').animateIconPanel(animateIconOpts);
});
