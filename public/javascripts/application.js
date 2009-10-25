/**
	Helps us display associated information from a list item
**/
function displayHoverList(event) {
	$('li.' + this["className"].replace(' ','_')).show();
}

function hideHoverList(event) {
	$('li.' + this["className"].replace(' ','_')).hide();
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

	
	$('#order_icon').click(function() {
		$('#lists').toggleClass('active');
		$('.order_box').toggle();
	})
});