// 高さの初期値を取得
var initInnerHeight = $('.newpost-text').innerHeight();
// inputイベント登録
$(document).on("input", '.newpost-text', e => {
  // 高さが初期値より大きくなる場合
  if (e.target.scrollHeight > initInnerHeight) {
    // 要素の高さを一度リセットし、入力内容に合わせる
    $(e.target).height(0).innerHeight(e.target.scrollHeight);
  }
});