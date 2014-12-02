// Paper
// Bootswatch
//= require jquery
//= require jquery_ujs
//= require paper/loader
//= require paper/bootswatch
//= require masonry/jquery.masonry
//= require zeroclipboard

  $(document).ready(function(){

  	var clip = new ZeroClipboard($(".clip_board"))

    $("#clear-test").on("click", function(){
      $("#fe_text").val("Copy me!");
      $("#testarea").val("");
    });


  	$('.fav').on('click', function(){
		location.reload();
	});
	
    $('.alert, .notice').fadeOut(5000);

    window.setInterval(function(){
		  /// call your function here
		  $(".arrow-up i, .arrow-up-large i").fadeOut(1000).fadeIn(1000)
		}, 10000);  
  });