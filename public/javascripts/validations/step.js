$(document).ready(function () {
  $('form.step').validate({
    rules: {
      "step[title]": {
        required: true,
        minlength: 12,
        
        remote: {
          url: "/steps/validate.json",
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