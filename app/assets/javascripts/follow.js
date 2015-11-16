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
      .success(function(data){ 
        var id = data.cohort_id
        showSuccessMessage(id);
      });
    })
}

function hideSuccessMessage(){
  $("span[class*='follow-success']").hide();
}

function showSuccessMessage(id){
  $(".follow-success-"+id).show();
}