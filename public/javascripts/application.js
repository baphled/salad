/**
	Helps us display associated information from a list item
**/
function displayHoverList(event) {
	$('li.' + this["className"].replace(' ','_')).show();
}

function hideHoverList(event) {
	$('li.' + this["className"].replace(' ','_')).hide();
}

function displayInfo(event,selector) {
  if("view" == $(event).html()) {
    $(event).html("hide");
  } else {    
    $(event).html("view");
  }
  $('#' +selector).toggle();
}

// This sets up the proper header for rails to understand the request type,
// and therefore properly respond to js requests (via respond_to block, for example)
$.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$(document).ready(function() {
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
	
  $('.views').hide();
	
  $('#order_icon').click(function() {
      $('#lists').toggleClass('active');
      $('.order_box').toggle();
  });
});
