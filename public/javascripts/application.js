// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
/*!
 * Shadow animation jQuery-plugin
 * http://www.bitstorm.org/jquery/shadow-animation/
 * Copyright 2010 Edwin Martin <edwin@bitstorm.org>
 * Released under the MIT and GPL licenses.
 */
 
var fire = false;

function removeBadLinks() {
  $('img:not(.loaded)').each(function(){
		if(this.readyState == 'uninitialized' || (typeof this.naturalWidth != "undefined" && this.naturalWidth == 0) ){
			$(this).parent().parent().remove();
		} else {
			$(this).parent().parent().addClass('loaded');
		}
	})
}
 
function endlessScroll(){
  if(nearBottomOfPage() && !fire) {
    fire = true;
    link = $('.pagination a.next_page:last');
    
    if(url.length == 0)
    {
      setTimeout("endlessScroll()",250);
    } else {
      url = link.attr('href');      
      $('.pagination').remove();
      $('<div/>').load(url + ' .shot, .pagination',function(){ 
        $(this).children().appendTo('#container');
  	    $('.caption').hide();       	    
        $('.pagination').hide();	    
        $('img:not(.loaded)').hide().load(function() {
          $(this).fadeIn().addClass('loaded');
        });      
        setTimeout("endlessScroll()",250);
        setTimeout("removeBadLinks()",2000);            
        fire = false;
      }); 
    }        
  } else {
    setTimeout("endlessScroll()",250);
  }
}
 
function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 450;
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
	
	$('.pagination').hide();
	
  $('#container').delegate(".shot","hoverenter",
    function() {
      $(this).find('.caption').fadeIn();
    }); 
  $('#container').delegate(".shot","hoverleave",  
    function() {
      $(this).find('.caption').fadeOut('fast');    
    });
  $('#container').delegate("img","load",  
    function() {
      $(this).fadeIn();    
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
  
  
  $('img').hide().load(function() {
    $(this).fadeIn().addClass('loaded');
  });
  
  // using some custom options
  setTimeout("endlessScroll()",500);  
  setTimeout("removeBadLinks()",2000);    
});

