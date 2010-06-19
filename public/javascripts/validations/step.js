$(document).ready(function () {
  $('form.step').customValidations({
    rules: {
      "step[title]": {
        required: true,
        minlength: 12,
        
        remote: {
          url: "/steps/validate_prefix.json",
          type: "get",
          data: {
            "title": function() {
              return $('#step_title').val();
            }
          }
        }
      }
    }
  });
});