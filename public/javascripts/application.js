// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function() {
	$("#display").hide();
	$("li.show_info_" + $id).click(function() {
		$(".displayed").animate({opacity: 'toggle',height: 'slide'},'slow');
		$(".info_" + $id).animate({opacity: 'toggle',height: 'slide'},'slow');
		return false;
	});
});