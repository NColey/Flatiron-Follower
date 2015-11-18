$(document).ready(function(){
  hideSuccessMessage();
  followAllListener();
})

function followAllListener(){
  $(".follow-all").on("ajax:success", function(event, data){
      var id = data.cohort_id
      showSuccessMessage(id);
    })
}

function hideSuccessMessage(){
  $("span[class*='follow-success']").hide();
}

function showSuccessMessage(id){
  $(".follow-success-"+id).show();
}
