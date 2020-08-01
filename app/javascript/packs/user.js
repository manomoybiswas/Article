$(document).ready(function(){
  $('#file-input').on('change', function() { 
    $('#update_avater').submit(); 
  });

  $('#datepicker1').datetimepicker({
    format: "DD/MM/YYYY"
  });
  $("#user_mobile").keypress(function(event){
    var key = event.charCode
    if ((event.location == 3 && key >= 96 && key <= 105) || (key >= 48 && key <= 57) || key == 8) {}
    else{ event.preventDefault(); }
  });
});