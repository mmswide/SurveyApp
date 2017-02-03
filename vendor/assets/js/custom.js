$( document ).ready(function() {
    
    // Write your custom Javascript codes here...
  
  
  /*menu handler*/
$(function(){
  function stripTrailingSlash(str) {
    if(str.substr(-1) == '/') {
      return str.substr(0, str.length - 1);
    }
    return str;
  }

  var url = window.location.pathname;  
  var activePage = stripTrailingSlash(url);

  $('.accordion-menu li a').each(function(){  
    var currentPage = stripTrailingSlash($(this).attr('href'));

    if (activePage == currentPage) {
      $(this).parent().addClass('active'); 
      $(this).parent().parent().parent().addClass('active open'); 
      $(this).parent().parent('.sub-menu').slideDown(200, function() {
            });

    } 
  });
});
    
});
