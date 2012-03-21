$(document).ready(function() {
	// Find the div with the id controller_name and get its class
	var currentController = "#" + $("#controller_name").attr("class") + "_menu";

	// Find the menu with the id of controller_name's class and set its
	// class to "current"
	$(currentController).addClass("active");

	// Find the div with the id action_name and get its class
	var currentAction = "#" + $("#action_name").attr("class") + "_menu_item";

	// Find the menu item with the id of action_name's class and set its
	// class to "current"
	$(currentAction).addClass("sub_nav_active");

	$(".click_to_close").click(function() {
		$(this).fadeTo(400, 0, function () {
			$(this).slideUp(400);
		});
		return false;
	});

	$("#icondock li a").tipsy ({ gravity: 'n' });

	//Accordion
	$('.acc_container').hide(); //Hide/close all containers
	$('.acc_trigger:first').addClass('active').next().show(); //Add "active" class to first trigger, then show/open the immediate next container

	//On Click
	$('.acc_trigger').click(function(){
		if( $(this).next().is(':hidden') ) { //If immediate next container is closed...
			$('.acc_trigger').removeClass('active').next().slideUp(); //Remove all "active" state and slide up the immediate next container
			$(this).toggleClass('active').next().slideDown(); //Add "active" state to clicked trigger and slide down the immediate next container
		}
		return false; //Prevent the browser jump to the link anchor
	});

	$('.check_all').click(
		function(){
			$(this).parent().parent().parent().parent().find("input[type='checkbox']").attr('checked', $(this).is(':checked'));
		}
	);
});

$.fn.extend({
	insertAtCaret: function(myValue)
	{
		this.each(function(i)
		{
			if (document.selection)
			{
				this.focus();
				sel = document.selection.createRange();
				sel.text = myValue;
				this.focus();
			}
			else
			{
				if (this.selectionStart || this.selectionStart == '0')
				{
					var startPos = this.selectionStart;
					var endPos = this.selectionEnd;
					var scrollTop = this.ScrollTop;

					this.value = this.value.substring(0, startPos) + myValue + this.value.substring(endPos, this.value.length);
					this.focus();
					this.selectionStart = startPos + myValue.length;
					this.selectionEnd = startPos + myValue.length;
					this.scrollTop = scrollTop;
				}
				else
				{
					this.value += myValue;
					this.focus();
				}
			}
		})
	}
})

$.fn.extend({
	insertImageTagAtCaret: function(imagePath, altText, isLink)
	{
		var imageTag = "";

		if (isLink)
		{
			imageTag = "<a href=\"" + imagePath + "\"><img src=\"" + imagePath + "\" alt=\"" + altText + "\"></a>";
		}
		else
		{
			imageTag = "<img src=\"" + imagePath + "\" alt=\"" + altText + "\">";
		}

		this.each(function(i)
		{
			if (document.selection)
			{
				this.focus();
				sel = document.selection.createRange();
				sel.text = imageTag;
				this.focus();
			}
			else
			{
				if (this.selectionStart || this.selectionStart == '0')
				{
					var startPos = this.selectionStart;
					var endPos = this.selectionEnd;
					var scrollTop = this.ScrollTop;

					this.value = this.value.substring(0, startPos) + imageTag + this.value.substring(endPos, this.value.length);
					this.focus();
					this.selectionStart = startPos + imageTag.length;
					this.selectionEnd = startPos + imageTag.length;
					this.scrollTop = scrollTop;
				}
				else
				{
					this.value += imageTag;
					this.focus();
				}
			}
		})
	}
})
