// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
/*!
 * Shadow animation jQuery-plugin
 * http://www.bitstorm.org/jquery/shadow-animation/
 * Copyright 2010 Edwin Martin <edwin@bitstorm.org>
 * Released under the MIT and GPL licenses.
 */
 
var currentPage = 1;

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
    $.get("/dribbble?page=" + currentPage, null, null, "script");
  } else {
    setTimeout("checkScroll()", 250);
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
  
  checkScroll();
  
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

