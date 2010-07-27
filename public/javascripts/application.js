// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
/*!
 * Shadow animation jQuery-plugin
 * http://www.bitstorm.org/jquery/shadow-animation/
 * Copyright 2010 Edwin Martin <edwin@bitstorm.org>
 * Released under the MIT and GPL licenses.
 */
 
$(document).ready(function() {
  
	$('input').each(function() {
		  if($(this).val() === '') {
  			$(this).val($(this).attr('title'));	
  		}
		
  		$(this).focus(function() {
  			if($(this).val() == $(this).attr('title')) {
  				$(this).val('').addClass('focused');	
  				$('#footer').unbind('mouseenter mouseleave');
  			}
  		});
  		$(this).blur(function() {
  			if($(this).val() === '') {
  				$(this).val($(this).attr('title')).removeClass('focused');	
  				$('#footer').hover(function() {
            $(this).animate({ height: '190px'}, 'fast');
          }, function() {
            $(this).animate({ height: '134px'}, 'fast');
          });
  			}
  		});
		});
		
	$('.caption').hide();
  
  $('.shot').hover(
    function() {
      $(this).find('.caption').fadeIn();
    }, 
    function() {
      $(this).find('.caption').fadeOut('fast');    
    }
  );
});

