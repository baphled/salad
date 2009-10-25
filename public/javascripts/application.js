/**
	Helps us display associated information from a list item
**/
function displayHoverList(event) {
	$('li.' + this["className"].replace(' ','_')).show();
}

function hideHoverList(event) {
	$('li.' + this["className"].replace(' ','_')).hide();
}

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

/**
	Used to toggle our order functionality
**/

$(document).ready(function() {
	
	$('#myTabs').tabs();
	
	var accOpts = {
		event:"click",
		autoHeight:false,
		fillSpace:false,
		navigation:true
	}
	$('.accordion').accordion(accOpts);
	
	$('#order_icon').click(function() {
		$('#lists').toggleClass('active');
		$('.order_box').toggle();
	})
});