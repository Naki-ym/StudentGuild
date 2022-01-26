$(function () {
  $(window).on("scroll", function () {
    const sliderHeight = $(".vidual-bg").height();
    const headerHeight = $("header").height();
    if (sliderHeight - headerHeight +15 < $(this).scrollTop()) {
      $(".header-logo").addClass("headerColorScroll");
      $(".header-list-item").addClass("headerColorScroll");
    } else {
      $(".header-logo").removeClass("headerColorScroll");
      $(".header-list-item").removeClass("headerColorScroll");
    }
  });
});
