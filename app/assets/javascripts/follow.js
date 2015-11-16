$(document).ready(function(){
  hideSuccessMessage();
  followAllListener();
})

function followAllListener(){
  $(".follow-all").on("click", function(event){
    event.preventDefault();
    var path = $(this).attr("href");
    $.ajax({
      method: "PUT",
      url: path,
    })
      .done(function() {
        showSuccessMessage();
      });
    })
}

function hideSuccessMessage(){
  $(".follow-success").hide();
}

function showSuccessMessage(){
  $(".follow-success").show();
}