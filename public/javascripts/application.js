$(document).ready(function() {
	$(".click_to_close").click(function() {
		$(this).fadeTo(400, 0, function () {
			$(this).slideUp(400);
		});
		return false;
	});
});
