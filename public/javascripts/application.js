// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function () {
    animate_divs('div.thumb','div.box');
	animate_divs('div.thumb_mini','div.box_mini');
});

/**
 * onHover in divs for thumbs
 */
function animate_divs(div_thumb,div_box){
    $(div_thumb).hover(
        function () {
            $(this).find('a.gallery-over').stop().fadeTo('fast', 1);
            $(this).find(div_box).stop().fadeTo('fast', 1);
            $(this).find('img').stop().fadeTo('fast', 0.3);
        },
        function () {
            $(this).find('a.gallery-over').stop().fadeTo('fast', 0);
            $(this).find(div_box).stop().fadeTo('fast', 0);
            $(this).find('img').stop().fadeTo('fast', 1);
        }
    );
}
/**
 *Prevents from double clicking submit buttons
 **/
function ctrl_dbl_click(){
    $('form').submit(function(){
        $('input[type=submit]', this).attr('disabled', true).attr("value", "Creando juguete...");
    });
}
