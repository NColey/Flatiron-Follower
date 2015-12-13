$(document).on('page:change', function(){
  filterStudentByCohortListener();
  showSubmitButton();
});

$(document).ready(function(){
  $('#sign-up-button-js').hide();
});

$(document).on('page:load', function(){
  $('#sign-up-button-js').hide();
});

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

function showSubmitButton(){
  $("#student-by-cohort-dropdown").change(function(){
    $('#sign-up-button-js').show();

  })

}