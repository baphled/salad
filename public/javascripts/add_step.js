$(document).ready(function() {
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
	$('body').click(function() {
		$autoComplete.hide();
	});
	
	$('#search_text').attr('autocomplete','off');
	$('#search_text').keyup(function() {
		$.ajax({
			'url': '/steps',
			'data': {'search_text': $('#search_text').val()},
			'dataType': 'json',
			'type': 'GET',
			'success': function(data) {
				if (data.length) {
					$autoComplete.empty();
					$.each(data, function(index, step) {
						if ('edit_story' == $('form').attr('class')) {
							$addr = $('form').attr('action') + "/edit";
						} else {
							$addr = $('form').attr('action') + "/new";
						}
						$('<li></li>')
								.html('<a href="' + $addr + '?steps[]=' + step['step']['id'] + '">'+step['step']['title'] + '</a>')
								.appendTo($autoComplete);
					});
					$autoComplete.show();
				}
			}
		});
	});
})