$(document).ready(function() {
	$(".click-to-close").click(function() {
		$(this).fadeTo(400, 0, function () {
			$(this).slideUp(400);
		});
		return false;
	});
});

if (navigator.appName != "Microsoft Internet Explorer") {
	window.addEventListener('load', function() {
		setTimeout(scrollTo, 0, 0, 1);
	}
	, false);
	window.addEventListener('load', setOrient, false);
	window.addEventListener('orientationchange', setOrient, false);
}

function setOrient() {
	var orient = Math.abs(window.orientation) === 90 ? 'land' : 'up';
	var cl = document.body.className;
	cl = cl.replace(/up|land/, orient);
	document.body.className = cl;
}

function loadpage(filename) {
	//var main_nav = $('#main-nav');
	var page = $('#page');
	var ajax = $('#ajax-loading');
	//main_nav.fadeOut(100);
	page.fadeOut(100, function() {
		ajax.show();
		page.load(filename, function() {
			ajax.hide();
			page.fadeIn();
			//main_nav.fadeIn();
		}
		);
	}
	);

	//history.pushState({ path : window.location.pathname }, '', window.location.pathname);

	return false;
}
