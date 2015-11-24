$(document).ready(function(){
  followAllListener();
})

function followAllListener(){
  $(".follow-all").on("ajax:success", function(event, data){
      var id = data.cohort_id;
      var name = data.cohort_name;
      var provider = data.provider;
      showSuccessMessage(id, name, provider);
    })
}

function showSuccessMessage(id, name, provider){
  $(".follow-success-"+provider+"-"+id).append(" | Woohoo! You're now following " + name + "!");
}
