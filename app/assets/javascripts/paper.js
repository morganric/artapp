// Paper
// Bootswatch
//= require jquery
//= require jquery_ujs
//= require paper/loader
//= require paper/bootswatch


  $(document).ready(function(){
    // $(".arrow-up i").fadeIn(1000).fadeOut(1000).fadeIn(1000).fadeOut(1000).fadeIn(1000);

    window.setInterval(function(){
  /// call your function here
  $(".arrow-up i").fadeOut(1000).fadeIn(1000)
}, 10000);  
  });