$(document).on('page:load', function(){
  filterStudentByCohortListener();
});
$(document).on("ready", function(){
  filterStudentByCohortListener();
})

function filterStudentByCohortListener(){
  var students = $("#student-by-cohort-dropdown").html();
  var blankStudent = "<option value>Students</option>";
  $("#student-by-cohort-dropdown").html(blankStudent);

  $("#cohort-dropdown").change(function(){

  var cohortID = $("#cohort-dropdown option:selected").val();
  var filterBy = "option[cohort-id='"+ cohortID + "']";
  var options = $(students).filter(filterBy)

  if(cohortID != ""){
     $("#student-by-cohort-dropdown").html(options).prepend(blankStudent);
  }

  });
}