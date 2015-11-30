$(document).on('page:load', function(){
  filterStudentByCohortListener();
});
$(document).on("ready", function(){
  filterStudentByCohortListener();
})

function filterStudentByCohortListener(){
  var students = $("#student-by-cohort-dropdown").html();

  $("#cohort-dropdown").change(function(){

  var cohortID = $("#cohort-dropdown option:selected").val();
  var filterBy = "option[value='"+ cohortID + "']";
  var options = $(students).filter(filterBy)

  if(cohortID != ""){
     $("#student-by-cohort-dropdown").html(options).prepend("<option value>Students</option>");
  }

  });
}