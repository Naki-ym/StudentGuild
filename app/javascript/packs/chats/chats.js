var headerHeight = $("header").outerHeight();
var windowHeight = $(window).height();
$(function(){
  $(".chat-wrapper").height(windowHeight - headerHeight);
});