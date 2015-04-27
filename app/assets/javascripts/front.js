//page load

jQuery(window).load(function() {
  jQuery('.page-loader').css('display', 'none');

  jQuery('#page').animate({
    opacity: 1
  }, 1000);

});


jQuery(document).ready(function() {

  //togles search field in the header
	jQuery('.search-submit').click(function(){
		jQuery(this).parent().toggleClass('open');
                                    jQuery('.navbar-nav').toggleClass('hide-menu');
	});


  //opens sidebar at smaller resolutions
  jQuery('.sidebar-open').click(function(){
    jQuery(this).toggleClass('fa-plus');
    jQuery(this).toggleClass('fa-minus');
    jQuery('.l-sidebar-left').toggleClass('show-sidebar');
    jQuery('.l-cont-side-wrap').toggleClass('move-right');

  });


    
  //checks to see if it should apply isotope to sidebar
  function footer_isotope(){
    var window_size = jQuery(window).width();
    var container = jQuery('.l-sidebar-right');

    if( window_size > 960 && window_size < 1270 ){
      jQuery(container).imagesLoaded(function(){
          jQuery(container).isotope({
              layoutMode:'fitRows',
              itemSelector:'.l-sidebar-widget',
              isAnimated:true,
              animationEngine:'jquery',
              animationOptions:{
                  duration:800,           
                  queue:false
              }
          });
      }); //imagesLoaded
    } else {
      //checks to see if isotope is initiliazed
      if(jQuery(".l-sidebar-right").hasClass('isotope')) {
        container.isotope('destroy');
        jQuery('.l-sidebar-right').removeAttr('style');
        jQuery('.l-sidebar-right').attr('style', 'height: auto');
      }
    } // end if
  }//footer_isotope()

  footer_isotope();

  jQuery(window).resize(function(){
    footer_isotope();
  });


//colorbox gallery
jQuery('a.colorbox').colorbox();


  //isotope for projects pages
  var container = jQuery('.l-project-posts');
  jQuery(container).imagesLoaded(function(){
      jQuery(container).isotope({
          layoutMode:'fitRows',
          itemSelector:'.project-post',
          isAnimated:true,
          animationEngine:'jquery',
          animationOptions:{
              duration:800,           
              queue:false
          }
      });
  });

  jQuery('.l-projects-categories li').click(function(){
      jQuery('.l-projects-categories li').removeClass();
      jQuery(this).addClass('background-theme-color background-text-color');
      var selector = jQuery(this).attr('data-filter');
      jQuery(container).isotope({ filter: selector });
      return false;
  });

});






