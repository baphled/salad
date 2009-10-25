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

/**
	Used to toggle our order functionality
**/

$(document).ready(function() {
	
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
	})
});