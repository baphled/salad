$(document).ready(function () {
  $('form.story').customValidations({
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
  if (window.location.pathname.indexOf('edit')) {
    $("#story_scenario").rules('remove', 'remote');
  };
});