// Paper
// Bootswatch
//= require jquery
//= require jquery_ujs
//= require paper/loader
//= require paper/bootswatch
//= require masonry/jquery.masonry


  $(document).ready(function(){

  	$('.fav').on('click', function(){
		location.reload();
	});
	
    $('.alert, .notice').fadeOut(5000);

    window.setInterval(function(){
		  /// call your function here
		  $(".arrow-up i, .arrow-up-large i").fadeOut(1000).fadeIn(1000)
		}, 10000);  
  });