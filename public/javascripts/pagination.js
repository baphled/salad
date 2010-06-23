$(function() {
	$(".pagination a").live("click", function(){
		$(".pagination").html("Page loading...");
		$.get(this.href, null, function() {
		  // All pagination data needs the following calls so we'll include them here instead
		  $('ul.items-list li > span').animateIconPanel({eventType: 'click', eventText: 'Click'});
      $('a[title]').tipsy({fade: true});
		}, "script");
		return false;
	});
	
	
});