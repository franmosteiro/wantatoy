// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function () {
	$('#title').focus();
	$('#toy_title').focus();	
	$('div.thumb').hover(
		function () {
			$(this).find('a.gallery-over').stop().fadeTo('fast', 1);
			$(this).find('div.box').stop().fadeTo('fast', 1);
			$(this).find('img').stop().fadeTo('fast', 0.3);
			},
		function () {
			$(this).find('a.gallery-over').stop().fadeTo('fast', 0);
			$(this).find('div.box').stop().fadeTo('fast', 0);
			$(this).find('img').stop().fadeTo('fast', 1);
			}
	);
	$('#contact_link').click(
		function(){
			$('#form').show(10);
			$('#contact_email').val('');
			$('#contact_email').focus();
		}
	);
	$('#cancel_link').click(
		function(){
			$('#form').hide(10);
			$('#error_explanation').hide();
		}		
	);
	if ($('#error_explanation').is (':visible')) {
		$('#form').show(1);
		$('#contact_email').focus();
	}
});
