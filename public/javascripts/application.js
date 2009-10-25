/**
	Helps us display associated information from a list item
**/
function displayHoverList(event) {
	$('li.' + this["className"].replace(' ','_')).show();
}

function hideHoverList(event) {
	$('li.' + this["className"].replace(' ','_')).hide();
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
	
	$('#order_icon').click(function() {
		$('#lists').toggleClass('active');
		$('.order_box').toggle();
	})
});