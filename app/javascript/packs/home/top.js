$(function(){
  $('header').addClass('top-header');
  $('.under-header').removeClass('under-header');
});

function fadeInAnime(){
  $('.vidual-article-box').each(function(){ //vidual-article-boxクラスの要素の
    var elemPos = $(this).offset().top+250; //200px下が
    var scroll = $(window).scrollTop();
    var windowHeight = $(window).height();
    if (scroll >= elemPos - windowHeight){
      $(this).addClass('fadeIn');
      // 画面内に入ったらfadeInクラスを追加
    }
  });
}
$(window).scroll(function (){
  fadeInAnime();/* アニメーション用の関数を呼ぶ*/
});

//任意のタブにURLからリンクするための設定
function GethashID (hashIDName){
  if(hashIDName){
    //タブ設定
    $('.tab li').find('a').each(function() { //タブ内のaタグ全てを取得
      var idName = $(this).attr('href'); //タブ内のaタグのリンク名（例）#lunchの値を取得	
      if(idName == hashIDName){ //リンク元の指定されたURLのハッシュタグ
        var parentElm = $(this).parent(); //タブ内のaタグの親要素（li）を取得
        $('.tab li').removeClass("active"); //タブ内のliについているactiveクラスを取り除き
        $(parentElm).addClass("active"); //リンク元の指定されたURLのハッシュタグとタブ内のリンク名が同じであれば、liにactiveクラスを追加
        //表示させるエリア設定
        $(".area-content").removeClass("is-active"); //もともとついているis-activeクラスを取り除き
        $(hashIDName).addClass("is-active"); //表示させたいエリアのタブリンク名をクリックしたら、表示エリアにis-activeクラスを追加	
      }
    });
  }
}

//タブをクリックしたら
$('.tab a').on('click', function() {
  var idName = $(this).attr('href'); //タブ内のリンク名を取得	
  GethashID (idName);//設定したタブの読み込みと
  return false;//aタグを無効にする
});