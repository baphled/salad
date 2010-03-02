$(document).ready(function () {
  $('form.story').validate({
    rules: {
      "story[scenario]": {required: true, minlength: 7,
        remote: {
          url: "/story/validate.json",
          type: "get",
          data: {
            "title": function() {
              return $('#story_scenario').val();
            }
          }
        }
      }
    }
  });
});