// This sets up the proper header for rails to understand the request type,
// and therefore properly respond to js requests (via respond_to block, for example)
$.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$(document).ready(function() {

  /**
   * Selector for our item fieldsets
   */
  var display_info = $("a.display_info");

  /**
   * We don't want our checkboxes viewable initially
   */
  $('.views').hide();
  
  /**
   * Handling the viewing and hiding of our item checkboxes
   */
  display_info.click(function(event) {
    $('fieldset.views').toggle(function() {
      if( 'view' == display_info.text().substr(0,4)) {
        display_info.text(display_info.text().replace('view', 'hide'));
      } else  {
        display_info.text(display_info.text().replace('hide', 'view'));
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
  
  $('#myTabs').tabs();
	
  var accOpts = {
    event: "click",
    autoHeight: false,
    fillSpace: false,
    navigation: true
  }
  $('.accordion').accordion(accOpts);

  $('#lists').addClass('ui-widget ui-widget-content ui-corner-all');
	
  $('#order_icon').click(function() {
      $('#lists').toggleClass('active');
      $('.order_box').toggle();
  });
});
