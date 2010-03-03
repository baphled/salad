$(document).ready(function () {
  $('form.story').validate({
    rules: {
      "story[scenario]": {required: true, minlength: 7,
        remote: {
          url: "/stories/validate.json",
          type: "get",
          data: {
            "scenario": function() {
              return $('#story_scenario').val();
            }
          }
        }
      }
    }
  });
});