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
      var result = generateStudentDivs(data);
      $("#students-collection").html(result);
    });
  })
}

function generateStudentDivs(array){
  var result = "";
  for(var i = 0; i < array.length; i++){
    result += "<div class='col-xs-4'><h4>"+array[i].name+"</h4><table class='table table-condensed'><tr><td class='col-md-2'><i class='fa fa-envelope-o'></i></td><td><a href='mailto:"+array[i].email+"'>"+array[i].email+"</a></td></tr><tr><td class='col-md-2'><i class='fa fa-github'></i></td><td>"+array[i].github_handle+"</td></tr><tr><td class='col-md-2'><i class='fa fa-twitter'></i></td><td>"+array[i].twitter_handle+"</td></tr></table></div>"
  };
  return result;

}