// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
/*!
 * Shadow animation jQuery-plugin
 * http://www.bitstorm.org/jquery/shadow-animation/
 * Copyright 2010 Edwin Martin <edwin@bitstorm.org>
 * Released under the MIT and GPL licenses.
 */
 
var fire = false;
 
function endlessScroll(){
  if(nearBottomOfPage() && !fire) {
    fire = true;
    url = $('.pagination a.next_page:last').attr('href');
    $('.pagination').remove();
    $('<div/>').load(url + ' #container',function(){ 
      $(this).appendTo('#container');
      setTimeout("endlessScroll()",250);
      fire = false;
    });
  } else {
    setTimeout("endlessScroll()",250);
  }
}
 
function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 150;
}

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}
 
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
  
  $('#container').delegate(".shot","hoverenter",
    function() {
      $(this).find('.caption').fadeIn();
    }); 
  $('#container').delegate(".shot","hoverleave",  
    function() {
      $(this).find('.caption').fadeOut('fast');    
    });
  
  /*$('.pagination a.next_page:last').depagify({    
    container: '#container',
    filter: '.shot',
    trigger: function () {
        return scrollDistanceFromBottom() < 10;
    },
    effect: function() {
        $(this).fadeIn('slow');
    },
    request: function(options) {
        $('.pagination').remove();
    },
    success: function(event, options) {
        $('.caption').hide();
    }
  });*/
  
  // using some custom options
  endlessScroll();
});

