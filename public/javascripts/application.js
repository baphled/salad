/**
	Helps us display associated information from a list item
**/
function displayFeature(event) {
	$('#' + this["id"] + '_feature').show();
}

function hideFeature(event) {
	$('#' + this["id"] + '_feature').hide();
}

function displayStory(event) {
	$('#' + this["id"] + '_story').show();
}

function hideStory(event) {
	$('#' + this["id"] + '_story').hide();
}

function displayStep(event) {
	$('#' + this["id"] + '_step').show();
}

function hideStep(event) {
	$('#' + this["id"] + '_step').hide();
}
/**
	Used to toggle our order functionality
**/

$(document).ready(function() {
	
	$('#myTabs').tabs();
	
	var accOpts = {
		event:"click",
		autoHeight:true,
		fillSpace:false,
		navigation:true
	}
	$('#accordion').accordion(accOpts);
	
	$('#order_icon').click(function() {
		$('#lists').toggleClass('active');
		$('.order_box').toggle();
	})
});