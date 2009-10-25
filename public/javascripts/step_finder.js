$(document).ready(function() {

  var $autoComplete = $('<ul class="autocomplete"></ul>')
			.hide()
			.insertAfter('#search_text');
			
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
						$('<li></li>')
								.html('<a href="/steps/' + step['step']['id'] + '">'+step['step']['title'] + '</a>')
								.appendTo($autoComplete);
					});
					$autoComplete.show();
				}
			}
		});
	});
})