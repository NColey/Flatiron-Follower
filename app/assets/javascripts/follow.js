$(document).on('page:load', function(){
  githubFollowRequestProcessingListener();
  followAllListener();
  unfollowAllListener();
  filterStudentListener();
});
$(document).on("ready", function(){
  githubFollowRequestProcessingListener();
  followAllListener();
  unfollowAllListener();
  filterStudentListener();
})


function followAllListener(){
  $("#follow_cohort").on("ajax:success", ".follow-all", function(event, data){
      var id = data.cohort_id;
      var name = data.cohort_name;
      var provider = data.provider;
      showSuccessMessage(id, name, provider);
      $(this).hide();
    })
}
function unfollowAllListener(){
  $("#follow_cohort").on("ajax:success", ".unfollow-all", function(event, data){
      var id = data.cohort_id;
      var name = data.cohort_name;
      var provider = data.provider;
      showUnfollowSuccessMessage(id, name, provider);
      $(this).hide();
    })
}

function githubFollowRequestProcessingListener(){
  $('.follow-all.btn-github').on("ajax:success", function(event, data){
    debugger;
  })
}

function showSuccessMessage(id, name, provider){
  $(".follow-success-"+provider+"-"+id).html("<p>Woohoo! You're now following " + name + "!</p>");
}
function showUnfollowSuccessMessage(id, name, provider){
  $(".follow-success-"+provider+"-"+id).html("<p>You're no longer following " + name + "!</p>");
}

function showProcessingMessage(){
  $('.btn-github.follow-all').append("Please wait, your request is being processed...")
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
      var student_divs = data.html;
      var cohort_html = data.cohort_html;
      $("#students-collection").html(student_divs);
      $("#follow_cohort").html(cohort_html);
    });
  })
}
