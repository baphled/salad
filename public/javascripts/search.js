$(document).ready(function() {
	/*
		Functionality need to create our search form and autocompletion
	*/
	var $search = $('#search').addClass('overlabel');
	var $searchInput = $search.find('input');
	var $searchLabel = $search.find('label');
	
	var $autoComplete = $('<ul class="autocomplete"></ul>')
			.hide()
			.insertAfter('#search_text');
			
	if ($searchInput.val()) {
		$searchLabel.hide();
	}
	
	$searchInput
		.focus(function() {
			$searchLabel.hide();
		})
		.blur(function() {
			$searchLabel.show();
	});
		
	$searchLabel.click(function() {
		$searchInput.trigger('focus');
	});
});