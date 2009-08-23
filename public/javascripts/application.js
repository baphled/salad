/**
	Helps us display associated information from a list item
**/
function displayInfo(e, reg) {
	$(reg).toggle().visible();
}

/**
	Used to toggle our order functionality
**/
function toggleOrder(e,reg) {
	$(reg).down('div').down('span').toggle('order_box');
	$('lists').down('span').toggleClassName('active');
}

$(document).ready(function() {
	$('#accordion').tabs();
});