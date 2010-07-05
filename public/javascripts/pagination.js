$(function() {
	$(".pagination a").live("click", function(){
		$(".pagination").html("Page loading...");
		// Ideally we should make a JSON or XML query to retrieve the needed data
		// From there we will need to repopulate the sidebar and list item elements with our results
		$.get(this.href, null, function() {
		  // All pagination data needs the following calls so we'll include them here instead
          $('ul.icons li .handler').button('option', 'icon');
          $('button.order_icon button.button').button({ option: 'text' });
          $('div#lists ul').customSortable();
		  $('ul.items-list li > span').animateIconPanel({eventType: 'click', eventText: 'Click'});
      $('a[title]').tipsy({fade: true});
		}, "script");
		return false;
	});
});