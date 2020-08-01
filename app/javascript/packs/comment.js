$(document).ready(function(){
  var path = window.location.pathname
  if (path.substring(path.substring(0, path.lastIndexOf("/")).lastIndexOf("/") + 1, path.lastIndexOf("/") ) == "posts"){
    setInterval(function(){
      console.log("render")
      $.ajax({
        url: "./refresh_comment",
        data: {id: path.substring(path.lastIndexOf("/") + 1)}
      })
    }, 60000);
  }
});
