$(document).on('page:load', function(){
  followAllListener();
  filterStudentListener();
})

function followAllListener(){
  $(".follow-all").on("ajax:success", function(event, data){
      var id = data.cohort_id;
      var name = data.cohort_name;
      var provider = data.provider;
      showSuccessMessage(id, name, provider);
      $(this).hide();
    })
}

function showSuccessMessage(id, name, provider){
  $(".follow-success-"+provider+"-"+id).append(" | Woohoo! You're now following " + name + "!");
}

function filterStudentListener(){
  $("#student-filter-dropdown").change(function(){
    var cohortId = $("#student-filter-dropdown option:selected").val();
    $.ajax({
      url: "students/filter",
      method: "GET",
      data: { cohort_id : cohortId},
    })
    .done(function(data){
      var result = data.html
      $("#students-collection").html(result);
    });
  })
}
