$(document).ready(function(){
  var path = window.location.pathname;
  var page = path.substring(path.lastIndexOf("/") + 1);
  var profile = path.substring(path.substring(0, path.lastIndexOf("/")).lastIndexOf("/") + 1, path.lastIndexOf("/") );
  if (page == "overview"){
    $(".menu-1").addClass("active");
    $(".page-title").text("OVERVIEW");
  }
  else if (page == "users"){
    $(".menu-2").addClass("active");
    $(".page-title").text("REGISTERED USERS");
  }
  else if (page == "categories"){
    $(".menu-3").addClass("active");
    $(".page-title").text("CATEGORIES");
  }
  else if (page == "posts"){
    $(".menu-4").addClass("active");
    $(".page-title").text("ARTICLES");
  }
  else if (profile == "users"){
    $(".menu-5").addClass("active");
    $(".page-title").text("USER PROFILE");
  }
})
