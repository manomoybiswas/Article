// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("jquery")
require("@rails/ujs").start()
require("turbolinks")
require("@rails/activestorage").start()
require("channels")
require("bootstrap")
require("packs/home")
require("packs/user")
require("packs/comment")

$(()=>$(".hide").fadeOut(4000));

$(document).ready(function() {
	var showChar = 130;
	var ellipsestext = "...";
  
  $('.more').each(function() {
		var content = $(this).html();

		if(content.length > showChar) {

			var c = content.substr(0, showChar);

			var html = c + '<span class="moreellipses">' + ellipsestext + '</span>'

      $(this).html(html);
		}
  });
  
  $('#filters').on('change', function() {
    this.form.submit();
	});
	
	setInterval(function(){
		var today = new Date();
		var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
];
	  var I = today.getHours();
	  var M = today.getMinutes();
		var S = today.getSeconds();
		var d = today.getDate();
		var b = today.getMonth();
		var Y = today.getFullYear();
		
	 if(S<10){
			 S = "0"+S;
	 }
	 if (M < 10) {
			M = "0" + M;
	}
	if (I > 12 && I<=24){ 
		I -= 12; 
		p = "PM"
	}
	else if (I >= 1 && I< 12){ 
		I = "0" + I;
		p = "AM"
	}
	else{p = "PM"}
	$(".timer").text(d + " " + monthNames[b] + ", " + Y + " " + I + ":" + M + ":" + S + " " + p);
	}, 1000);
});
