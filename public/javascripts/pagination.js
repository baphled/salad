var Pagination = function() {
	$(".pagination a").live("click", function(){
		$(".pagination").html("Page loading...");
		$.get(this.href, null, null, "script");
		return false;
	});
};

$(function() {
	Pagination();
});