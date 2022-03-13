var headerHeight = $("header").outerHeight();
var windowHeight = $(window).height();
$(function(){
  $(".chat-wrapper").height(windowHeight - headerHeight);
});

// 高さの初期値を取得
var initInnerHeight = $('.new-msg').innerHeight();
// inputイベント登録
$(document).on("input", '.new-msg', e => {
    // 高さが初期値より大きくなる場合
    if (e.target.scrollHeight > initInnerHeight) {
      if (200 > e.target.scrollHeight) {
        // 要素の高さを一度リセットし、入力内容に合わせる
        $(e.target).height(0).innerHeight(e.target.scrollHeight);
        $(".new-msg").removeClass("ok-scroll");
      } else {
        $(".new-msg").addClass("ok-scroll");
      }
    }
});

$(".new-msg")
  .focusin(function(e) {
    $(".border").addClass("box-focus");
  })
  .focusout(function(e) {
    $(".border").removeClass("box-focus");
  });